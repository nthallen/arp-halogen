/* rfd.c
   Driver for new RF Power supplies with RS-232 interfaces
   Assumption will be that there are 4 amplifiers
   connected to /dev/ser[1-4].

   Driver will read commands from RF interface:
     S[1-4]=[1-4]  Set amplifier [1-4] to power level [1-4]
     Empty command designates Quit according to convention.

   Driver will send data to telemetry via Col_send()
     Power level for each amplifier (two bits each?)
     Temperature for each amplifier (4.1 fixed?)

   Driver will poll each amplifier for temperature data.
   If an amplifier does not respond, driver will retry
   command periodically.
*/
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include "nortlib.h"
#include "nl_assert.h"
#include "collect.h"
#include "rfd.h"

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
    write( char *wbuf, int n );
    const int bsz = 20;
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
    void read();
};

class ctrl_if {
  public:
    ctrl_if();
    ~ctrl_if();
    void operate();
    col_if col;
    cmd_if cmd;
    rfamp *rf[4];
};

static ctrl_if *ctrl;

rfamp::rfamp(int n) {
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
  // Set serial parameters using tcsetattr
}

void rfamp::write( char *wbuf, int n ) {
  int rv = write( fd, wbuf, n );
  if ( rv == -1 ) {
    if (report_err()) {
      nl_error( 2, "Error writing to RF%d: %s",
	rf_num, strerror(errno));
    }
  } else if ( rv != n ) {
    if (report_err()) {
      no_error( 2,
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
  int rv, i, j;
  nl_assert( fd != -1);
  rv = read(fd,buf+nb, bsz-nb);
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
	  collection.report_power(rf_num, buf[i+3]-'0');
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
      if ( nb - i >= 8 ) {
	if ( buf[i+1] == 'T' && buf[i+2] == '=' &&
	     isdigit(buf[i+3]) && isdigit(buf[i+4]) &&
	     isdigit(buf[i+5]) && buf[i+6] == 'C' &&
	     (buf[i+7] == '\r' || buf[i+7] == '\n') ) {
	  collection.report_temp(rf_num, atoi(buf+3));
	  i += 8;
	  if (report_suc())
	    nl_error(0,"RF%d recovered reading T", rf_num);
	} else {
	  i = synt_err("Error reading T", i);
	}
	req_pending = 0;
      }
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
    int rv;
    obuf[2] = n + '0';
    write(obuf,4);
  }
}

int rfamp::report_err() {
  if ( err_throttle > 10 ) return 0;
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
    for ( j = 0, i = bp; i < nb; i++ ) {
      if ( isprint(buf[i] ) fbuf[j++] = buf[i++];
      else {
	int nc = snprintf(fbuf+j,4,"<%02X>", buf[i++] & 0xFF);
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
  tmid = Col_send_init("RFD", &RFD, sizeof(RFD));
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

void report_temp(int n, unsigned char T) {
  nl_assert(n >= 1 && n <= 4);
  RFD.temp[n-1] = T;
  RFD.alive |= (1 << (n-1));
}

void report_power(int n, unsigned char P) {
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
 * Command format is: Pn=m\r where n and m are in [1-4]
 */
int cmd_if::read() {
  char buf[20];
  int nb;
  nb = read(fd, buf, 20);
  if ( nb == -1 ) {
    nl_error(2, "Error reading from cmd_if: %s", strerror(errno));
    return 1;
  } else if ( nb == 0 ) {
    return 1;
  } else if ( nb != 5 ) {
    nl_error(2, "Expected 5 characters, received %d", nb);
  } else if (buf[0] == 'P' && buf[1] >= '1' && buf[1] <= '4'
	    && buf[2] == '=' && buf[3] >= '1' && buf[3] <= '4'
	    && (buf[4] == '\n' || buf[4] == '\r')) {
    rf[buf[1]-'1']->set_power(buf[3]-'1');
  } else {
    nl_error(2, "Syntax error from cmd_if" );
  }
  return 0;
}

int main(int argc, char **argv) {
  cmd_if cmd;
}

ctrl_if::ctrl_if() {
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
