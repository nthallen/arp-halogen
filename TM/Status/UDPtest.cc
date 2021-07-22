/* UDPtest: Try to figure out what causes sendto() errors */
#include "UDP.h"
#include "oui.h"
#include <time.h>
#include <unistd.h>
#include "../udpext.h"
#include "nortlib.h"

bool udpext_debug = false;

int main(int argc, char **argv) {
  oui_init_options(argc, argv);
  UDPbcast UDP("10.9.1.255", "5100"); // ER-2 LAN
  while (true) {
    double dt = time(NULL);
    int status = 3;
    if (udpext_debug) {
      nl_error(0, "HAL,%s,%d", UDP.ISO8601(dt), status);
    } else {
      UDP.Broadcast("HAL,%s,%d", UDP.ISO8601(dt), status);
    }
    sleep(1);
  }
}
