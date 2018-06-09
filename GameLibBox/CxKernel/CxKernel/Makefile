CXKernel: check
	@echo "-------- CXKernel --------"

	@echo && echo "Now compile a SWC and demo SWF"
	"$(FLASCC)/usr/bin/g++" -jvmopt=-Xmx1G $(BASE_CFLAGS) -O4 CXTcpEncrypt.cpp CXFileEncrypt.cpp main.cpp -emit-swc=cx.kernel -o CxKernel.swc -lAS3++

include ../../Makefile.common

clean:
	rm -f *.swf *.swc *.bc *.exe
