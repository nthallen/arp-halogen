/* rfd.cc
   Driver for new RF Power supplies with RS-232 interfaces
   Assumption will be that there are 4 amplifiers
   connected to /dev/ser[1-4].

   Driver will read commands from RF interface:
     S[1-4]=[1-4]  Set amplifier [1-4] to power level [1-4]
     Empty command designates Quit according to convention.

   Driver will send data to telemetry via Col_send() under the
     name "RFD" using the structure defined in rfd.h
     Power level for each amplifier
     Temperature for each amplifier (3.0)

   Driver will poll each amplifier for temperature data.
   If an amplifier does not respond, driver will retry
   command periodically.
*/
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <sys/select.h>
#include <ctype.h>
#include <stdlib.h>
#include <termios.h>
#include "nortlib.h"
#include "nl_assert.h"
#include "collect.h"
#include "tm.h"
#include "rfd.h"
#include "oui.h"

class col_if {
  public:
    col_if();
    ~col_if();
    int fd();
    void send();
    void report_temp(int n, unsigned char T);
    void report_power(int n, unsigned char P);
  private:
    RFD_t RFD;
    send_id tmid;
};

class rfamp {
  public:
    rfamp(int n);
    ~rfamp();
    void poll();
    void read();
    void set_power(int n);
    int fd;
  private:
    int report_err();
    int report_suc();
    int synt_err(const char *desc, int i);
    void write( const char *wbuf, int n );
    static const int bsz = 20;
    int rf_num;
    char buf[bsz+1];
    char obuf[5];
    int nb; // number of characters currently in the buffer
    int req_pending;
    int poll_requested;
    int pwr_requested;
    int err_throttle;
};

class cmd_if {
  public:
    cmd_if(const char *name);
    ~cmd_if();
    int fd;
    int read();
};

class ctrl_if {
  public:
    ctrl_if();
    ~ctrl_if();
    void operate();
    void set_power(int rfn, int n);
    void report_temp(int n, unsigned char T);
    void report_power(int n, unsigned char P);
  private:
    cmd_if cmd;
    col_if col;
    rfamp *rf[4];
};

static ctrl_if *ctrl;

rfamp::rfamp(int n) {
  struct termios io;
  nb = 0;
  req_pending = 0;
  poll_requested = 0;
  rf_num = n;
  err_throttle = 0;
  strcpy(obuf, "PS0\r" );
  nb = snprintf(buf, bsz, "/dev/ser%d", rf_num);
  nl_assert(nb < bsz);
  fd = open(buf, O_RDWR | O_NONBLOCK);
  if ( fd == -1 ) {
    nl_error( 2, "Error opening %s: %s", buf, strerror(errno) );
    return;
  }
  if (tcgetattr(fd, &io))
    nl_error( 3, "RF%d: Error from tcgetattr: %s",
      rf_num, strerror(errno));
  nl_error( -2, "c_iflag = %08X\n", io.c_iflag );
  nl_error( -2, "c_oflag = %08X\n", io.c_oflag );
  nl_error( -2, "c_cflag = %08X\n", io.c_cflag );
  nl_error( -2, "c_lflag = %08X\n", io.c_lflag );

  io.c_iflag = IGNBRK | IGNPAR;
  io.c_oflag = 0;
  io.c_cflag = CREAD | CS8;
  io.c_lflag = 0;
  if (cfsetispeed(&io, 38400))
    nl_error(2, "RF%d: Error setting ispeed: %s", rf_num,
      strerror(errno));
  if (cfsetospeed(&io, 38400))
    nl_error(2, "RF%d: Error setting ospeed: %s", rf_num,
      strerror(errno));
  if ( tcsetattr(fd, TCSANOW, &io) == -1 )
    nl_error( 2, "RF%d: Error from tcsetattr: %s",
      rf_num, strerror(errno));

  // Flush the input buffer
  do {
    nb = ::read(fd, buf, bsz);
  } while (nb > 0);
  nb = 0;
}

rfamp::~rfamp() {
  if ( fd != -1 )
    close(fd);
}

void rfamp::write( const char *wbuf, int n ) {
  int rv = ::write( fd, wbuf, n );
  if ( rv == -1 ) {
    if (report_err()) {
      nl_error( 2, "Error writing to RF%d: %s",
	rf_num, strerror(errno));
    }
  } else if ( rv != n ) {
    if (report_err()) {
      nl_error( 2,
	"Unexpected return writing to RF%d: wrote %d, returned %d",
	rf_num, n, rv );
    }
  }
}

void rfamp::poll() {
  if ( fd >= 0 ) {
    if ( req_pending ) {
      ++poll_requested;
      if ( poll_requested >= 2 ) {
	if (report_err()) {
	  nl_error(2, "RF%d not responding", rf_num );
	}
	req_pending = 0;
	if (pwr_requested) {
	  set_power(pwr_requested);
	} else {
	  poll();
	}
      }
    } else {
      write( "RT?\r", 4 );
      req_pending = 1;
      poll_requested = 0;
    }
  }
}

/**
 * Handles responses of the formats:
 *   PS=n\r
 *   RT=nnnC\r
 */
void rfamp::read() {
  int rv, i;
  nl_assert( fd != -1);
  rv = ::read(fd,buf+nb, bsz-nb);
  if ( rv == 0 || (rv == -1 && errno == EAGAIN) )
    return; // No data
  if ( rv == -1 ) {
    if ( report_err() )
      nl_error( 2, "Error reading from RF%d: %s", strerror(errno) );
  } else {
    nb += rv;
    buf[nb] = '\0';
    i = 0;
    while (isspace(buf[i])) ++i;
    if ( buf[i] == 'P' ) {
      if ( nb - i >= 5 ) {
	if ( buf[i+1] == 'S' && buf[i+2] == '=' &&
	     buf[i+3] >= '1' && buf[i+3] <= '4' &&
	     ( buf[i+4] == '\r' || buf[i+4] == '\n')) {
	  ctrl->report_power(rf_num, buf[i+3]-'0');
	  pwr_requested = 0;
	  i += 5;
	  if (report_suc())
	    nl_error(0,"RF%d recovered reading P", rf_num);
	} else {
	  i = synt_err("Error reading P", i);
	}
	req_pending = 0;
      }
    } else if ( buf[i] == 'R' ) {
      if ( nb - i >= 8 && buf[i+1] == 'T' && buf[i+2] == '=' &&
	   isdigit(buf[i+3]) && isdigit(buf[i+4]) &&
	   isdigit(buf[i+5]) && buf[i+6] == 'C' &&
	   (buf[i+7] == '\r' || buf[i+7] == '\n') ) {
	ctrl->report_temp(rf_num, atoi(buf+i+3));
	i += 8;
	if (report_suc())
	  nl_error(0,"RF%d recovered reading T", rf_num);
      } else if ( nb - i >= 8 && buf[i+1] == 'T' &&
	  buf[i+2] == '=' && buf[i+3] == '-' &&
	  isdigit(buf[i+4]) && isdigit(buf[i+5]) &&
	  buf[i+6] == 'C' &&
	   (buf[i+7] == '\r' || buf[i+7] == '\n') ) {
	ctrl->report_temp(rf_num, -atoi(buf+i+4));
	i += 8;
	if (report_suc())
	  nl_error(0,"RF%d recovered reading cold T", rf_num);
      } else {
	i = synt_err("Error reading T", i);
      }
      req_pending = 0;
    } else {
      i = synt_err("Unexpected start char", i);
    }
    while (isspace(buf[i])) ++i;
    if ( i == nb ) {
      nb = 0;
    } else {
      memmove(buf, buf+i, nb-i);
      nb -= i;
    }
  }
  if ( req_pending == 0 ) {
    if ( pwr_requested )
      set_power(pwr_requested);
    else if ( poll_requested )
      poll();
  }
}

void rfamp::set_power(int n) {
  if ( fd < 0 ) return;
  if ( n < 1 || n > 4 ) {
    nl_error( 2, "Invalid power level requested: %d", n );
    return;
  }
  pwr_requested = n;
  if ( ! req_pending ) {
    obuf[2] = n + '0';
    write(obuf,4);
  }
}

int rfamp::report_err() {
  if ( err_throttle > 3 ) return 0;
  ++err_throttle;
  return 1;
}

int rfamp::report_suc() {
  if ( err_throttle ) {
    err_throttle = 0;
    return 1;
  }
  return 0;
}

/**
 * Checks report_err()
 * Reformats buffer to eliminate unprintables
 * searches forward from position i to newline,
 * returning position of following character.
 */
int rfamp::synt_err(const char *desc, int bp) {
  if ( report_err() ) {
    char fbuf[4*bsz+1];
    int i,j ;
    for ( j = 0, i = bp; i < nb; ++i ) {
      if ( isprint(buf[i]) ) fbuf[j++] = buf[i];
      else {
	int nc = snprintf(fbuf+j,5,"<%02X>", buf[i] & 0xFF);
	if ( nc > 4 ) nc = 4;
	j += nc;
      }
    }
    fbuf[j] = '\0';
    nl_error(2,"RF%d: %s: '%s'", rf_num, desc, fbuf);
  }
  while (buf[bp] != '\0') {
    if ( buf[bp] == '\r' || buf[bp] == '\n' )
      return bp+1;
    ++bp;
  }
  return bp;
}

col_if::col_if() {
  int i;
  tmid = Col_send_init("RFD", &RFD, sizeof(RFD), 0);
  for (i = 0; i < 4; ++i) {
    RFD.power[i] = 0;
    RFD.temp[i] = 0;
  }
  RFD.alive = 0;
}

col_if::~col_if() {
  Col_send_reset(tmid);
}

int col_if::fd() {
  return tmid == 0 ? -1 : tmid->fd;
}

void col_if::send() {
  Col_send(tmid);
  RFD.alive = 0;
}

void col_if::report_temp(int n, unsigned char T) {
  nl_assert(n >= 1 && n <= 4);
  RFD.temp[n-1] = T;
  RFD.alive |= (1 << (n-1));
}

void col_if::report_power(int n, unsigned char P) {
  nl_assert(n >= 1 && n <= 4);
  RFD.power[n-1] = P;
  RFD.alive |= (1 << (n-1));
}

cmd_if::cmd_if(const char *name) {
  fd = tm_open_name(tm_dev_name(name), NULL, O_RDONLY | O_NONBLOCK);
}

cmd_if::~cmd_if() {
  if ( fd != -1 ) close(fd);
}

/**
 * @return non-zero if command is quit (empty)
 * Command format is: Sn=m\r where n and m are in [1-4]
 */
int cmd_if::read() {
  char buf[20];
  int nb;
  nb = ::read(fd, buf, 20);
  if ( nb == -1 ) {
    nl_error(2, "Error reading from cmd_if: %s", strerror(errno));
    return 1;
  } else if ( nb == 0 ) {
    return 1;
  } else if ( nb != 5 ) {
    nl_error(2, "Expected 5 characters, received %d", nb);
  } else if (buf[0] == 'S' && buf[1] >= '1' && buf[1] <= '4'
	    && buf[2] == '=' && buf[3] >= '1' && buf[3] <= '4'
	    && (buf[4] == '\n' || buf[4] == '\r')) {
    ctrl->set_power(buf[1]-'0', buf[3]-'0');
  } else {
    nl_error(2, "Syntax error from cmd_if: '%s'", buf );
  }
  return 0;
}

ctrl_if::ctrl_if() : cmd("cmd/RF") {
  int i;
  for (i = 0; i < 4; ++i) {
    rf[i] = new rfamp(i+1);
  }
}

ctrl_if::~ctrl_if() {
  int i;
  for (i = 0; i < 4; ++i)
    delete rf[i];
}

void ctrl_if::set_power(int rfn, int n) {
  nl_assert(rfn >= 1 && rfn <= 4);
  rf[rfn-1]->set_power(n);
}

void ctrl_if::report_temp(int n, unsigned char T) {
  col.report_temp(n,T);
}

void ctrl_if::report_power(int n, unsigned char P) {
  col.report_power(n,P);
}

void ctrl_if::operate() {
  for (;;) {
    int i, w, rv;
    fd_set rfdset, wfdset;
    FD_ZERO(&rfdset);
    FD_ZERO(&wfdset);
    w = col.fd();
    FD_SET(w, &wfdset);
    FD_SET(cmd.fd, &rfdset);
    if ( cmd.fd > w ) w = cmd.fd;
    for (i = 0; i < 4; ++i ) {
      if ( rf[i]->fd != -1 ) {
	FD_SET( rf[i]->fd, &rfdset );
	if ( rf[i]->fd > w ) w = rf[i]->fd;
      }
    }
    ++w;
    rv = select(w, &rfdset, &wfdset, NULL, NULL);
    if (rv == -1)
      nl_error(3, "Error from select: %s", strerror(errno));
    if (FD_ISSET(cmd.fd, &rfdset)) {
      if ( cmd.read() ) return;
    }
    if (FD_ISSET(col.fd(), &wfdset)) {
      col.send();
      for ( i = 0; i < 4; ++i )
	rf[i]->poll();
    }
    for ( i = 0; i < 4; ++i ) {
      if (FD_ISSET(rf[i]->fd, &rfdset))
	rf[i]->read();
    }
  }
}

int main(int argc, char **argv) {
  oui_init_options(argc, argv);
  ctrl = new ctrl_if;
  nl_error(0, "Installed");
  ctrl->operate();
  delete ctrl;
  nl_error(0, "Terminating");
  return 0;
}
