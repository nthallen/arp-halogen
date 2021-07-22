#include <errno.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <unistd.h>
#include <stdarg.h>
#include "UDP.h"
#include "nortlib.h"
#include "nl_assert.h"

UDPbcast::UDPbcast(const char *broadcast_ip,
                   const char *broadcast_port,
                   int buflen)
    : buf(0),
      buflen(buflen),
      broadcast_ip(broadcast_ip),
      broadcast_port(broadcast_port),
      ok_status(false),
      ov_status(false) {
  buf = new char[buflen];
  UDP_init();
}

/**
 * @return non-zero on error
 */
int UDPbcast::UDP_init() {
  bcast_sock = socket(AF_INET, SOCK_DGRAM, 0);
  if (bcast_sock == -1) {
    nl_error(nl_response, "Unable to create UDP socket: %s", strerror(errno));
    return 1;
  }
  int broadcastEnable = 1;
  int ret = setsockopt(bcast_sock, SOL_SOCKET, SO_BROADCAST,
    &broadcastEnable, sizeof(broadcastEnable));
  if (ret == -1) {
    nl_error(nl_response, "setsockopt failed: %s", strerror(errno));
    return 1;
  }
  struct addrinfo hints, *res;
  hints.ai_flags = AI_NUMERICHOST;
  hints.ai_family = PF_INET;
  hints.ai_socktype = SOCK_DGRAM;
  hints.ai_protocol = IPPROTO_UDP;
  hints.ai_addrlen = 0;
  hints.ai_canonname = 0;
  hints.ai_addr = 0;
  hints.ai_next = 0;
  if (getaddrinfo(broadcast_ip, broadcast_port, &hints, &res)) {
    nl_error(nl_response, "getaddrinfo failed: %s", strerror(errno));
    return 1;
  }
  nl_assert(res->ai_next == 0);
  nl_assert(res->ai_addr != 0);
  nl_assert(((unsigned)res->ai_addrlen) <= sizeof(s));
  memcpy(&s, res->ai_addr, res->ai_addrlen);
  addrlen = res->ai_addrlen;
  freeaddrinfo(res);
  ok_status = true;
  return 0;
}

UDPbcast::~UDPbcast() {
  if (bcast_sock != -1) {
    close(bcast_sock);
    bcast_sock = -1;
  }
  if (buf) {
    delete(buf);
    buf = 0;
  }
}

bool UDPbcast::ok() { return ok_status; }

/**
 * Example:
 *   UDP.Broadcast("HWV,%s,%d,%.2lf\r\n", ISO8601(utc), status, mr);
 * @return non-zero on error
 */
int UDPbcast::Broadcast(const char *fmt, ...) {
  if (!ok_status && UDP_init())
    return 1;
  va_list args;
  int msglen;
  va_start(args, fmt);
  msglen = vsnprintf(buf, 80, fmt, args);
  va_end(args);
  if (msglen >= buflen) {
    if (!ov_status) {
      nl_error(2, "UDP Broadcast buffer overflow");
      ov_status = true;
    }
    return 1; // Don't broadcast a truncated message
  }
  if (ok_status) {
    int nb = sendto(bcast_sock, buf, msglen, 0, (sockaddr*)&s, addrlen);
    if (nb < 0) {
      nl_error(2, "sendto() returned error %d: %s", errno, strerror(errno));
      ok_status = false;
      close(bcast_sock);
      bcast_sock = -1;
      return 1;
    } else if (nb < msglen) {
      nl_error(2, "sendto() expected %d, returned %d", msglen, nb);
      return 1;
    }
  } else {
    return 1;
  }
  return 0;
}

const char *UDPbcast::ISO8601(double utc) {
  // yyyy-mm-ddThh:mm:ss.mmm
  static char buf[24];
  time_t iutc = floor(utc);
  double futc = utc - iutc;
  if (futc >= 1) {
    futc -= 1.0;
    ++iutc;
  } else if (futc < 0) {
    futc += 1.0;
    --iutc;
  }
  struct tm *tms = gmtime(&iutc);
  snprintf(buf, 24, "%4d-%02d-%02dT%02d:%02d:%06.3lf",
    tms->tm_year + 1900,
    tms->tm_mon + 1,
    tms->tm_mday,
    tms->tm_hour,
    tms->tm_min,
    tms->tm_sec + futc);
  return buf;
}
