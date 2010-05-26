sinclude Makeconf

.PHONY: all check

all:
	$(MAKE) -C ann all
	$(MAKE) -C ann/bindings bindings-octave
	cp ann/bindings/ann.oct .

check: all
	$(MAKE) -C ann/bindings check

clean:
	-$(RM) *.o octave-core core *.oct *~
	$(MAKE) -C ann clean
	$(MAKE) -C ann/bindings clean
