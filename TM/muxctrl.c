/* muxctrl.c: Mux control driver.
  Alternately talks to collection and cmdsrvr, updating
  mux address.
 */
#include "oui.h"
#include "nortlib.h"
#include "collect.h"
#include "tm.h"

unsigned short MUXCtrl;

int main( int argc, char **argv ) {
  send_id MC;
  unsigned short MuxAddr = 0;
  int rv;

  oui_init_options(argc, argv);

  /* Establish connection to collection */
  MC = Col_send_init("MUXCtrl", &MUXCtrl, sizeof(MUXCtrl), 1);

  /* Establish connection to cmdsrvr */
  cic_init();

  nl_error(0, "Installed" );
  for (;;) {
    rv = ci_sendfcmd(2, "Mux address set %d\n", MuxAddr );
    if (rv != 0) break;
    if (Col_send(MC)) break;
    MuxAddr = (MuxAddr + 1) & 0xF;
  }
  cic_reset();
  Col_send_reset(MC);
  nl_error(0, "Terminating");
  return 0;
}
