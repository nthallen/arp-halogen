LDFLAGS=-Wl,-rpath -Wl,/usr/local/lib -L /usr/local/lib
CPPFLAGS= -I /usr/local/include
CXXFLAGS= -Wall -g
LIBS=-lsocket -ltmpp -ltm -lnort

IWG1SRC = IWG1.cc IWG1oui.c
IWG1OBJ = ${addsuffix .o, ${basename $(IWG1SRC) } } 
IWG1TGT = IWG1

.PHONY : all clean

all : IWG1

$(IWG1TGT) : $(IWG1OBJ)
	$(LINK.cc) -o $(IWG1TGT) $(IWG1OBJ) $(LIBS)
	usemsg $(IWG1TGT) IWG1oui.c
IWG1oui.c : IWG1.oui
	oui -o IWG1oui.c IWG1.oui

clean :
	rm -f *.o IWG1oui.c IWG1
