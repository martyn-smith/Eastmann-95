SHELL:= /bin/bash
sdate := $(shell date +"%d%m%y")
ldate := $(shell date +"%Y-%m-%d")
cdate := $(shell date +"%d%m%C")

.PHONY: clean te tedbg lib

te: src/*.f95
	gfortran -fall-intrinsics -fdefault-real-8 \
		-O3 -std=f2003 -o te src/main.f95;

tedbg: src/*.f95
	gfortran -fall-intrinsics -fbacktrace -fdefault-real-8 \
	    -ffpe-trap=invalid,zero,overflow,underflow,denormal -fimplicit-none \
		-g3 -Wall -Wno-unused-dummy-argument \
		-std=f2003 -o tedbg src/main.f95;

lib: src/*.f95
	gfortran -fall-intrinsics -fdefault-real-8 -fPIC \
		-O3 -shared -std=f2003 -o telib.so src/main.f95;


clean:
	rm -f *.dat *.mod *.so errors*.txt te tedbg telib.so
