.PHONY : clean all
all : UDPtest
clean :
	rm -f *.o UDPtest UDPtestoui.cc

UDPtest : UDPtest.o UDPtestoui.o
UDPtestoui.o : UDPtestoui.cc
UDPtestoui.cc : ../udpext.oui
	oui -o UDPtestoui.cc ../udpext.oui
