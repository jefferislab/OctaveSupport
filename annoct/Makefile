# Makefile for Octave extension matpow

MKOCTFLAGS="-I. -IANN"

.phony: all
all: annoct.oct

.phony: clean
clean:
	rm -f annoct.oct *.o

.phony: distclean
distclean: clean
	rm -f *~ octave-core core

.phony: test
test: annoct.oct
	octave --silent test_annoct.m

%.oct: %.cc
	mkoctfile -I. -IANN $<
