#
# IPWorks IPC 2024 C++ Edition - Sample Project
#
# This sample project demonstrates the usage of IPWorks IPC in a 
# simple, straightforward way. It is not intended to be a complete 
# application. Error handling and other checks are simplified for clarity.
#
# www.nsoftware.com/ipworksipc
#
# This code is subject to the terms and conditions specified in the 
# corresponding product license agreement which outlines the authorized 
# usage and restrictions.
#

ifeq ($(shell uname -s), Darwin) # MACOS
R_PATH=-Wl,-rpath,../../lib64/,-rpath,.

FRAMEWORK = -framework Carbon -framework Security
LD_FLAGS = -lipworksipc.24.0 -L../../lib64/ -lresolv
LD_FLAGS_SRC = -lz -lresolv
OS_CFLAGS = -D UNIX -arch arm64
MACOS = "darwin% Darwin% macos%"

all:
	g++ $(OS_CFLAGS) -D UNIX -o pipeserver pipeserver.cpp  -I../../include/ $(LD_FLAGS) $(FRAMEWORK) $(R_PATH)

src: ../../src/ipworksipc.o
	g++ $(OS_CFLAGS) -o pipeserver ../../src/ipworksipc.o pipeserver.cpp  $(LD_FLAGS_SRC) $(FRAMEWORK)

../../src/ipworksipc.o:
	g++ -c -fno-exceptions -fno-rtti -fPIC -arch arm64 -o ../../src/ipworksipc.o ../../src/ipworksipc.cpp

else # LINUX
CPU=$(shell uname -m)
# Assumed that a product is always built for Windows-x64 platform
ifeq ($(CPU), $(filter $(CPU), i386 i686))
  LIB=lib
endif
ifeq ($(LIB),)
  LIB=lib64
endif

R_PATH=-Wl,-rpath,../../$(LIB)/,-rpath,.
LD_FLAGS = -lipworksipc -ldl -lpthread -L../../$(LIB)/ -ldl -lpthread
LD_FLAGS_SRC = -lz -ldl -lpthread

all:
	g++ -D UNIX  -o pipeserver pipeserver.cpp  -I../../include/ $(LD_FLAGS) $(R_PATH)

src: ../../src/ipworksipc.o
	g++ -D UNIX -o pipeserver ../../src/ipworksipc.o pipeserver.cpp  -I../../include/ $(LD_FLAGS_SRC)

../../src/ipworksipc.o:
	g++ -c -fno-exceptions -fno-rtti -fPIC -o ../../src/ipworksipc.o ../../src/ipworksipc.cpp

clean:
	rm -f ../../src/*.o
	rm -f pipeserver *.o
endif