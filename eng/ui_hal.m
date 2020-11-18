function ui_hal
f = ne_dialg('Harvard Halogens',1);
f = ne_dialg(f, 'add', 0, 1, 'ghalc', 'Counts' );
f = ne_dialg(f, 'add', 1, 0, 'phalca', 'A' );
f = ne_dialg(f, 'add', 1, 0, 'phalcb', 'B' );
f = ne_dialg(f, 'add', 1, 0, 'phalcc', 'C' );
f = ne_dialg(f, 'add', 1, 0, 'phalcd', 'D' );
f = ne_dialg(f, 'add', 0, 1, 'ghalcs', 'Ct Stat' );
f = ne_dialg(f, 'add', 1, 0, 'phalcshc', 'H Ct' );
f = ne_dialg(f, 'add', 0, 1, 'ghalf', 'Flows' );
f = ne_dialg(f, 'add', 1, 0, 'phalfsp', 'Set Pt' );
f = ne_dialg(f, 'add', 0, 1, 'ghalgd', 'Gas Deck' );
f = ne_dialg(f, 'add', 1, 0, 'phalgdf', 'Flows' );
f = ne_dialg(f, 'add', 1, 0, 'phalgdhp', 'HP' );
f = ne_dialg(f, 'add', 1, 0, 'phalgdlp', 'LP' );
f = ne_dialg(f, 'add', 1, 0, 'phalgdt', 'T' );
f = ne_dialg(f, 'add', 0, 1, 'ghalhk', 'HK' );
f = ne_dialg(f, 'add', 1, 0, 'phalhks', 'Switches' );
f = ne_dialg(f, 'add', 1, 0, 'phalhkt', 'T' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'ghall', 'Lamps' );
f = ne_dialg(f, 'add', 1, 0, 'phalldt', 'Det T' );
f = ne_dialg(f, 'add', 1, 0, 'phallir', 'IR' );
f = ne_dialg(f, 'add', 1, 0, 'phallirs', 'IR Set' );
f = ne_dialg(f, 'add', 1, 0, 'phalllmt', 'LMT' );
f = ne_dialg(f, 'add', 1, 0, 'phallp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'phallrfbw', 'RFBW' );
f = ne_dialg(f, 'add', 1, 0, 'phallrffw', 'RFFW' );
f = ne_dialg(f, 'add', 1, 0, 'phallrfs', 'RF Set' );
f = ne_dialg(f, 'add', 1, 0, 'phalls', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'ghalp', 'Power' );
f = ne_dialg(f, 'add', 1, 0, 'phalpvi', 'V28I' );
f = ne_dialg(f, 'add', 1, 0, 'phalpvv', 'V28V' );
f = ne_dialg(f, 'add', 0, 1, 'ghalpressure', 'Pressure' );
f = ne_dialg(f, 'add', 1, 0, 'phalpressuredp', 'DP' );
f = ne_dialg(f, 'add', 1, 0, 'phalpressurep', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'phalpressuret', 'T' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'ghalpump', 'Pump' );
f = ne_dialg(f, 'add', 1, 0, 'phalpumps', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'ghalr', 'Rovers' );
f = ne_dialg(f, 'add', 1, 0, 'phalrt', 'T' );
f = ne_dialg(f, 'add', 0, 1, 'ghals', 'Software' );
f = ne_dialg(f, 'add', 1, 0, 'phalssw', 'SW1' );
f = ne_dialg(f, 'add', 1, 0, 'phalssw2', 'SW2' );
f = ne_dialg(f, 'add', 0, 1, 'ghalsoldrv', 'Soldrv' );
f = ne_dialg(f, 'add', 1, 0, 'phalsoldrvs', 'Solenoids' );
f = ne_dialg(f, 'add', 1, 0, 'phalsoldrvss', 'Sol Stat' );
f = ne_dialg(f, 'add', 0, 1, 'ghalt', 'Temps' );
f = ne_dialg(f, 'add', 1, 0, 'phalta', 'Air' );
f = ne_dialg(f, 'add', 1, 0, 'phalte', 'Exh' );
f = ne_dialg(f, 'add', 1, 0, 'phaltsfb', 'SF1B' );
f = ne_dialg(f, 'add', 1, 0, 'phaltsff', 'SF1F' );
f = ne_dialg(f, 'add', 1, 0, 'phaltsf2b', 'SF2B' );
f = ne_dialg(f, 'add', 1, 0, 'phaltsf2f', 'SF2F' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'ghalthrottle', 'Throttle' );
f = ne_dialg(f, 'add', 1, 0, 'phalthrottleb', 'Bits 1' );
f = ne_dialg(f, 'add', 1, 0, 'phalthrottlebits2', 'Bits 2' );
f = ne_dialg(f, 'add', 1, 0, 'phalthrottlebits', 'Bits' );
f = ne_dialg(f, 'add', 1, 0, 'phalthrottlep', 'Pot' );
f = ne_dialg(f, 'add', 1, 0, 'phalthrottles', 'Step' );
f = ne_dialg(f, 'add', 0, 1, 'ghaldh', 'DH1' );
f = ne_dialg(f, 'add', 1, 0, 'phaldhs', 'Set' );
f = ne_dialg(f, 'add', 1, 0, 'phaldhi', 'I' );
f = ne_dialg(f, 'add', 1, 0, 'phaldhv', 'V' );
f = ne_dialg(f, 'add', 1, 0, 'phaldhr', 'R' );
f = ne_dialg(f, 'add', 1, 0, 'phaldhp', 'P' );
f = ne_dialg(f, 'add', 0, 1, 'ghaldh2', 'DH2' );
f = ne_dialg(f, 'add', 1, 0, 'phaldh2s', 'Set' );
f = ne_dialg(f, 'add', 1, 0, 'phaldh2i', 'I' );
f = ne_dialg(f, 'add', 1, 0, 'phaldh2v', 'V' );
f = ne_dialg(f, 'add', 1, 0, 'phaldh2r', 'R' );
f = ne_dialg(f, 'add', 1, 0, 'phaldh2p', 'P' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'ghaldh3', 'DH3' );
f = ne_dialg(f, 'add', 1, 0, 'phaldh3s', 'Set' );
f = ne_dialg(f, 'add', 1, 0, 'phaldh3i', 'I' );
f = ne_dialg(f, 'add', 0, 1, 'ghaldhtr', 'D Htr' );
f = ne_dialg(f, 'add', 1, 0, 'phaldhtrv', 'V' );
f = ne_dialg(f, 'add', 1, 0, 'phaldhtrp', 'Pwr' );
f = ne_dialg(f, 'add', 0, 1, 'ghaltm', 'T Mbase' );
f = ne_dialg(f, 'add', 1, 0, 'phaltmtd', 'T Drift' );
f = ne_dialg(f, 'add', 1, 0, 'phaltmcpu', 'CPU' );
f = ne_dialg(f, 'add', 1, 0, 'phaltmram', 'RAM' );
f = ne_dialg(f, 'add', 1, 0, 'phaltmd', 'Disk' );
f = ne_listdirs(f, 'Hal_Data_Dir', 13);
f = ne_dialg(f, 'newcol');
ne_dialg(f, 'resize');
