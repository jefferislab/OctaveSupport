#-----------------------------------------------------------------------------
# Top-level Makefile for ANN.
#
# ANN: Approximate Nearest Neighbors
# Version: 1.1 05/03/05
#-----------------------------------------------------------------------------
# Copyright (c) 1997-2005 University of Maryland and Sunil Arya and
# David Mount.  All Rights Reserved.
# 
# This software and related documentation is part of the Approximate
# Nearest Neighbor Library (ANN).  This software is provided under
# the provisions of the Lesser GNU Public License (LGPL).  See the
# file ../ReadMe.txt for further information.
# 
# The University of Maryland (U.M.) and the authors make no
# representations about the suitability or fitness of this software for
# any purpose.  It is provided "as is" without express or implied
# warranty.
#-----------------------------------------------------------------------------
# Revision 0.1  09/06/97
#	alpha release
# Revision 0.2  06/26/98
#	Minor changes to fix compilation errors on SGI systems.
# Revision 1.0  04/01/05
#	Initial release (finally!)
#	Added linux-g++ target
# Revision 1.1  05/03/05
#	Added macosx-g++ target
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# main make entry point
#-----------------------------------------------------------------------------
all:
	$(MAKE) -C src targets
	$(MAKE) -C test targets
	$(MAKE) -C sample targets
	$(MAKE) -C ann2fig targets

#-----------------------------------------------------------------------------
# generate SWIG bindings
#-----------------------------------------------------------------------------
bindings: bindings-octave

bindings-octave: 
	$(MAKE) -C bindings bindings-octave

#-----------------------------------------------------------------------------
# Remove .o files and core files
#-----------------------------------------------------------------------------
clean:
	$(MAKE) -C src clean
	$(MAKE) -C test clean
	$(MAKE) -C sample clean
	$(MAKE) -C ann2fig clean
