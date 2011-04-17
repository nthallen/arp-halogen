; Modes
; mode 0: Instantaneous soldrv shut down mode
; mode 1: Orderly shut down soldrv cycle
; mode 2: NO addition, identical addition to both ducts
; mode 3: NO addition in duct 2 only

Command_Set = 'A'

; Gas Deck Solenoids
; Bank #1, previous: N2H    ClNH  NO2H   O3H   NO    Clx na     na
; Bank #1, previous: N2xH1  CNxH1 NO2xH1 O3xH1 NOxH1 xH1 N2LAS  O3xH2
; Bank #1, new     : AirxH1 CNxH1 NO2xA1 NO2xP NOxH1 xH1 AirLAS spare1
  solenoid  AirxH1    22 23  0
  solenoid  CNxH1     10 11  0
  solenoid  NO2xA1    14 15  0
  solenoid  NO2xP      4  5  0
  solenoid  NOxH1      8  9  0
  solenoid  xH1       28 29  0
  solenoid  AirLAS    48 49  0  
  solenoid  spare1     2  3  0  

; Bank #2, previous: N2N    ClNN  NO2N   O3N    NO2x1  NO2x2 F143   C2H2
; Bank #2, previous: N2xN   CNxN  NO2xN  O3xN   xN1    xN2   N2xH2  NOxH2
; Bank #2, new     : spare3 CNxH2 NO2xA2 spare4 spare2 xH2   AirxH2 NOxH2
; NOTE: F143<->N2N and C2H2<->O3N solenoid cable defs have been switched 
  solenoid  spare3      24 25  0
  solenoid  CNxH2       12 13  0
  solenoid  NO2xA2      16 17  0
  solenoid  spare4       6  7  0
  solenoid  spare2      18 19  0
  solenoid  xH2         20 21  0
  solenoid  AirxH2       0  1  0
  solenoid  NOxH2       26 27  0

; These commands are positive shutoffs for the FC's - use carefully
; previous names: NOFLC  O3FLC  CNFLC   NO2FLC
; previous names: NOxH1C NOxH2C CNxH1NC NO2xH1NC
; new names     : NOxH1C NOxH2C CNxHC   NO2xNC
  solenoid  NOxH1C    34 35 0
  solenoid  NOxH2C    42 43 0
  solenoid  CNxHC     38 39 0
  solenoid  NO2xNC    46 47 0

; Flow controllers - enable NOxH1F by shutting off NOxH1C for example
; previous names: NOFLW   O3FLW   CNFLW     NO2FLW
; previous names: NOxH1F  NOxH2F  CNxH1F    NO2xH1NF
; new names     : NOxH1F  NOxH2F  CNxHF     NO2xNF
; TM name       : NOH1Set NOH2Set ClONO2Set NO2FlSet


dtoa  NOxH1F  0xCEE   {Z:0 A:300  B:200	 C:110  D:70  E:340}
dtoa  NOxH2F  0xD60   {Z:0 A:1600 B:1100 C:700  D:200 E:340}
dtoa  CNxHF   0xCEC   {Z:0 A:2047 B:1639 C:1229 D:819 E:409}
dtoa  NO2xNF  0xC60   {Z:0 A:2047 B:1639 C:1024 D:819 E:409}

; Status byte - for communication with ClN.tma algo
dtoa  Sol1S0  0x0000  {Z:0 }
dtoa  Sol1S1  0x0000  {Z:10 }
dtoa  Sol1S2  0x0000  {Z:20 A:21 B:22 C:23 D:24 E:25 K:28 Q:29}
dtoa  Sol1S3  0x0000  {Z:30 A:31 B:32 C:33 D:34 E:35 K:38 Q:39}

Resolution = 1/1

routine duct1off {
  Initialize AirxH1  :_
  Initialize NOxH1   :_
  Initialize xH1     :_
  Initialize NOxH1C  :O
  Initialize NOxH1F  :Z
}

  
routine duct2off {
  Initialize AirxH2   :_
  Initialize NOxH2    :_
  Initialize xH2      :_
  Initialize NOxH2C   :O
  Initialize NOxH2F   :Z
}

routine NODuct1 {
  xH1     :___OO:OOOOO:OOOOO:OOOOO:OOOOO:OOOOO:OO___
  AirxH1  :___OO:OOOOO:OOOOO:OOOOO:OOOOO:OOOOO:OO___
  NOxH1   :____O:OOOOO:OOOOO:OOOOO:OOOOO:OOOOO:_____
  NOxH1C  :OOOO_:_____:_____:_____:_____:_____:OOOOO
  NOxH1F  :ZZZZA:AAAAA:BBBBB:BBCCC:CCCCD:DDDDD:ZZZZZ

}
routine NODuct2 {
  xH2     :___OO:OOOOO:OOOOO:OOOOO:OOOOO:OOOOO:OO___
  AirxH2  :___OO:OOOOO:OOOOO:OOOOO:OOOOO:OOOOO:OO___
  NOxH2   :____O:OOOOO:OOOOO:OOOOO:OOOOO:OOOOO:_____
  NOxH2C  :OOOO_:_____:_____:_____:_____:_____:OOOOO
  NOxH2F  :ZZZZA:AAAAA:BBBBB:BBCCC:CCCCD:DDDDD:ZZZZZ

}

; mode 0: Instantaneous soldrv shut down mode
mode 0 {
  duct1off
  duct2off
  Sol1S0   :Z
}


; mode 1: NO Off
mode 1 {
  select 0
}

; mode 2: NO addition, identical addition to both ducts
mode 2 {
  NODuct1
  NODuct2
  Sol1S2  :ZQQQQ:AAAAA:BBBBB:BBCCC:CCCCD:DDDDD:QQQQQ^
}
