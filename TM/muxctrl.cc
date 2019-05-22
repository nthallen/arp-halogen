/* muxctrl.c: Mux control driver.
  Alternately talks to collection and cmdsrvr, updating
  mux address.
 */
#include "oui.h"
#include "nortlib.h"
//#include "collect.h"
#include "Selector.h"
#include "SerSelector.h"
#include "tm.h"

unsigned short MUXCtrl;

class muxctrlr : public Selectee {
  public:
    muxctrlr();
    int ProcessData(int flag);
  private:
    unsigned short MuxAddr;
};

muxctrlr::muxctrlr() : Selectee() {
  MuxAddr = 0;
  cic_init();
  flags = Selector::gflag(0);
}

int muxctrlr::ProcessData(int flag) {
  int rv = ci_sendfcmd(2, "Mux address set %d\n", MuxAddr );
  if (rv != 0) return 1;
  MuxAddr = (MuxAddr + 1) & 0xF;
  return 0;
}

int main( int argc, char **argv ) {
  // unsigned short MuxAddr = 0;
  // int rv;

  oui_init_options(argc, argv);

  /* Establish connection to collection */
  // MC = Col_send_init("MUXCtrl", &MUXCtrl, sizeof(MUXCtrl), 1);
  Selector S;
  TM_Selectee *TM = new TM_Selectee("MUXCtrl", &MUXCtrl, sizeof(MUXCtrl));
  S.add_child(TM);
  Cmd_Selectee *Quit = new Cmd_Selectee();
  S.add_child(Quit);
  muxctrlr *mux = new muxctrlr();
  S.add_child(mux);

  nl_error(0, "Installed" );
  S.event_loop();
  nl_error(0, "Terminating");
  return 0;
}
