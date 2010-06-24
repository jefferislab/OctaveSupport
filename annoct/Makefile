# Makefile for Octave extension matpow

MKOCTFLAGS="-I. -IANN"
# DEBUG = -O0 -g
RELEASE = -O2
CXXFLAGS = "-Wall $(RELEASE)"

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
	octave --silent --eval 'test annoctsearch'

%.oct: %.cc
	CXXFLAGS=$(CXXFLAGS) mkoctfile -I. -IANN  $< ANN.cpp kd_pr_search.cpp kd_split.cpp kd_util.cpp kd_fix_rad_search.cpp kd_search.cpp kd_tree.cpp kd_dump.cpp bd_pr_search.cpp bd_tree.cpp perf.cpp bd_fix_rad_search.cpp bd_search.cpp brute.cpp
