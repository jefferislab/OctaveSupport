sinclude ../../Makeconf

bindings-octave: ann.oct
ann.oct: ann_wrap.cpp ../include/ANN/ANN.h ../include/ANN/ANNperf.h ../include/ANN/ANNx.h
	$(MKOCTFILE) -DSTATIC_LINKED -o ann.oct -I../include -L../lib -lANN ann_wrap.cpp

ifdef SWIG
ann_wrap.cpp: ann.i
	$(SWIG) -c++ -octave -o ann_wrap.cpp ann.i
endif

clean:
	rm -f *.oct *.o *~ octave-core 
ifdef SWIG
	rm -f ann_wrap.cpp
endif


OCTAVE_TEST_CASES =   \
	basic \
	bd_tree \
	empty \
	fatal \
	kd_tree

NOT_BROKEN_OCTAVE_TEST_CASES = $(OCTAVE_TEST_CASES:=.octave-test)
.PHONY: check
check: $(NOT_BROKEN_OCTAVE_TEST_CASES)
%.octave-test:
	octave -q tests/octave/$*.m > /dev/null

