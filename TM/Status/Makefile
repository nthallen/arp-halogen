CXXFLAGS=-I/usr/local/include -I../ -Wall -g
LDFLAGS=-g
include /usr/local/share/huarp/appgen.mk
.PHONY : clean all
all : UDPtest
clean :
	rm -f *.o UDPtest UDPtestoui.cc

UDPtest : UDPtest.o UDPtestoui.o UDP.o
	$(LINK.normCXX) UDPtest.o UDPtestoui.o UDP.o -lsocket -ltmpp -ltm -lnort
	$(OUIUSE) UDPtestoui.cc
UDPtestoui.o : UDPtestoui.cc
UDPtestoui.cc : UDPtest.oui
	oui -o UDPtestoui.cc UDPtest.oui
