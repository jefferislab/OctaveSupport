This repository currently contains two [GNU Octave][oct] packages that wrap Arya and Mount's [ANN][ann] (Approximate Nearest Neighbour) package.

  * Official octave-ann package by Xavier Delacour
  * My own annoct package

ANN library
===========
This can generate both KD and BD trees for a set of N-dimensional points that can be used for efficient exact or approximate nearest neighbour searching for a query point.

octave-ann package
==================

  * http://octave-swig.sourceforge.net/octave-ann.html

This package written by Xavier Delacour achieves a full wrapping of ANN via SWIG.  Although it is therefore very complete it seems to me to provide weak support for the most common use case - multiple query points against multiple target points. The ANN library only provides a function to query a single point. This function must be called repeatedly when there are many query points. For C code, this is no problem, but when the function is called from Octave there is significant overhead.

annoct package
==============

This package that I have written has not been properly released and is still very rough. It provides only one function [`annoctsearch`][aos] along with documentation, examples and tests:

    [idx, dst] = annoctsearch (data, query, k, epsl, asm)

annoctsearch allows a dxN set of query points to be matched against a dxM set of data points. The library currently defaults to float (single) input and output but can be compiled to expect double data.

[ann]: http://www.cs.umd.edu/~mount/ANN/
[oct]: http://www.gnu.org/software/octave/
[aos]: https://github.com/jefferis/OctaveSupport/blob/master/annoct/annoctsearch.m
