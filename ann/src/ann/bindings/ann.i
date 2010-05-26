// Copyright (c) 2008, Xavier Delacour <xavier.delacour@gmail.com>
// All rights reserved.
//
// This software and related documentation is part of the Approximate
// Nearest Neighbor Library (ANN).  This software is provided under
// the provisions of the Lesser GNU Public License (LGPL).  See the
// file ../ReadMe.txt for further information.

%module ann

%{
#include <ANN/ANN.h>
#include <ANN/ANNperf.h>
#include <ANN/ANNx.h>
%}

// take matrix in place of (ANNpointArray pa,int n,int dd)
%typemap(typecheck,precedence=SWIG_TYPECHECK_INTEGER) (ANNpointArray pa,int n,int dd,bool own_pts) {
   $1 = (*$input).is_matrix_type() ? 1 : 0;
}
%typemap(in,numinputs=1) (ANNpointArray pa,int n,int dd,bool own_pts) {
  if (!$input.is_matrix_type()) {
    error("points must be given by matrix (n x dd)"); SWIG_fail;
  }
  Matrix m=$input.matrix_value();
  $2=m.rows();
  $3=m.cols();
  $1=annAllocPts($2,$3);
  for (int j=0;j<m.rows();++j)
    for (int k=0;k<m.cols();++k)
      $1[j][k]=m(j,k);
  $4=true;
}

// take vector in place of ANNpoint
%typemap(typecheck,precedence=SWIG_TYPECHECK_INTEGER) (ANNpoint) {
   $1 = (*$input).is_matrix_type() ? 1 : 0;
}
%typemap(in) ANNpoint {
  if (!$input.is_matrix_type()) {
    error("point must be given by matrix (1 x dim or dim x 1)"); SWIG_fail;
  }
  Array<double> p=$input.vector_value();
  $1=annAllocPt(p.numel());
  for (int j=0;j<p.numel();++j)
    $1[j]=p(j);
}
%typemap(freearg,noblock=1) ANNpoint {
  annDeallocPt($1);
}

// take k and return [nn_idx,dd] in place of (int k,ANNidxArray nn_idx,ANNdistArray dd)
%typemap(typecheck,precedence=SWIG_TYPECHECK_INTEGER) (int k,ANNidxArray nn_idx,ANNdistArray dd) {
   $1 = (*$input).is_scalar_type() ? 1 : 0;
}
%typemap(in,noblock=1) (int k,ANNidxArray nn_idx,ANNdistArray dd) {
  if (!SWIG_IsOK(SWIG_AsVal_int($input,&$1))) {
    error("k must be given by integer"); SWIG_fail;
  }
  $2=new ANNidx[$1];
  $3=new ANNdist[$1];
}
%typemap(argout) (int k,ANNidxArray nn_idx,ANNdistArray dd) {
  RowVector nn_idx($1);
  RowVector dd($1);
  for (int j=0;j<$1;++j) {
    nn_idx(j)=$2[j];
    dd(j)=$3[j];
  }
  %append_output(nn_idx);
  %append_output(dd);
  delete [] $2;
  delete [] $3;
}

// replace (std::ostream& out) with std::cout
%typemap(in,numinputs=0) std::ostream& out {
  $1=&std::cout;
}

// argout typemap for (ANNkdStats& st)
%typemap(in,numinputs=0,noblock=1) ANNkdStats& st (ANNkdStats tmp) {
  $1=&tmp;
}
%typemap(argout) ANNkdStats& st {
  %append_output(SWIG_NewPointerObj(new ANNkdStats(*$1),SWIGTYPE_p_ANNkdStats,1));
}

// catch fatal errors
%exception {
  try {
    $action;
  } catch (ANN_exception& e) {
    error("ANN fatal error: %s",e.msg.c_str());
  }
}

%include "../include/ANN/ANN.h"
%include "../include/ANN/ANNperf.h"
%include "../include/ANN/ANNx.h"

