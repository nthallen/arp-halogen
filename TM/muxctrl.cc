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

uint8_t mode_NO[] = {0, 11};
uint8_t mode_N2[] = {1, 12};
uint8_t mode_N22[] = {2, 9};
uint8_t mode_Air[] = {4, 13};

class muxctrlr : public Selectee {
  public:
    muxctrlr();
    int ProcessData(int flag);
    void set_mode(unsigned length, uint8_t *addrs);
  private:
    /** Holds the next Mux address */
    unsigned short MuxAddr;
    /** If zero, just increment MuxAddr */
    unsigned mode_length;
    unsigned mode_idx;
    uint8_t *mode_addrs;
};

muxctrlr::muxctrlr() : Selectee() {
  MuxAddr = 0;
  cic_init();
  flags = Selector::gflag(0);
  mode_length = 0;
  mode_addrs = 0;
  mode_idx = 0;
}

muxctrlr::set_mode(unsigned length, uint8_t *addrs) {
  mode_length = length;
  mode_addrs = addrs;
  mode_idx = 0;
  if (mode_length > 0)
    MuxAddr = mode_addrs[mode_idx++]; // prep for next address
}

int muxctrlr::ProcessData(int flag) {
  int rv = ci_sendfcmd(2, "Mux address set %d\n", MuxAddr );
  if (rv != 0) return 1;
  MuxAddr = (MuxAddr + 1) & 0xF;
  return 0;
}

class muxcmd : public Cmd_Selectee {
  public:
    inline muxcmd(muxctrlr *mux)
      : Cmd_Selectee("cmd/Mux"),
        mux(mux) {}
    int ProcessData(int flag);
  private:
    muxctrlr *mux;
};

/**
 * Command format: M\d+ = Select mode #
 *                 Q = Quit
 */
int muxcmd::ProcessData(int flag) {
  if (flag & Selector::Sel_Read) {
    int mode;
    fillbuf();
    cp = 0;
    if (nc == 0 || buf[cp] == 'Q') {
      consume(nc);
      return 1;
    }
    if (not_str("M") ||
        not_int(mode)) {
      if (cp >= nc)
        report_err("Expected M<mode>");
    } else {
      switch (mode) {
        case 0: mux->set_mode(0, 0); break;
        case 1: mux->set_mode(sizeof(mode_NO), mode_NO); break;
        case 2: mux->set_mode(sizeof(mode_N2), mode_N2); break;
        case 3: mux->set_mode(sizeof(mode_Air), mode_Air); break;
        default:
          nl_error(1, "Invalid mode: %d", mode);
      }
    }
    consume(nc);
    report_ok();
  }
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
  muxctrlr *mux = new muxctrlr();
  S.add_child(mux);
  // Cmd_Selectee *Quit = new Cmd_Selectee();
  // S.add_child(Quit);
  muxcmd *cmd = new muxcmd(mux);
  S.add_chile(cmd);

  nl_error(0, "Installed" );
  S.event_loop();
  nl_error(0, "Terminating");
  return 0;
}
