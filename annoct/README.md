Installation
============

Known to work on linux/gcc4. First ensure that both `octave` and `mkoctfile` are in your path. See [this page](http://www.gnu.org/software/octave/doc/interpreter/Getting-Started-with-Oct_002dFiles.html#Getting-Started-with-Oct_002dFiles) for details about compiling octfiles.

Then:

    cd /some/sensible/place
    git clone https://github.com/jefferis/OctaveSupport
    cd OctaveSupport/annoct
    make
    make test

Now you should be ready to go in Octave.

License
=======
LGPL>=2 for Octave wrapping in part since

1. some wrapper code was adapted from LGPL2 code by Shai Bagon available here:
    http://www.wisdom.weizmann.ac.il/~bagon/matlab.html
and released under LGPLv2
2. original ANN library is released under LGPL

Citations (for ANN)
===================

@INPROCEEDINGS{Mount1993,
  author = {Sunil Arya and David M. Mount},
  title = {Approximate Nearest Neighbor Queries in Fixed Dimensions},
  booktitle = {Proc. 4th Ann. ACM-SIAM Symposium on Discrete Algorithms (SODA)},
  year = {1993},
  pages = {271-280},
  owner = {bagon},
  timestamp = {2009.02.04}
}

@ELECTRONIC{Mount2006,
  author = {David M. Mount and Sunil Arya},
  month = {August},
  year = {2006},
  title = {ANN: A Library for Approximate Nearest Neighbor Searching},
  note = {version 1.1.1},
  url = {http://www.cs.umd.edu/~mount/ANN/},
  owner = {bagon},
  timestamp = {2009.02.04}
}
