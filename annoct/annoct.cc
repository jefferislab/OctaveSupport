#include <octave/oct.h>
#include <math.h>    // math routines
#include "ANN.h"     // ANN library header
#include <ov-scalar.h>

static bool
	any_bad_argument(const octave_value_list& args);
 
DEFUN_DLD(annoct, args, nargout,
           "Find k nearest neighbours for each query point from target ")
{
	if (any_bad_argument(args))
		return octave_value_list();

    Matrix data(args(0).matrix_value()); // data points
	double *data_as_double_array = data.fortran_vec();
    Matrix query(args(1).matrix_value()); // query points
	double eps = args(3).double_value(); // error bound for approx search

	dim_vector dims_d = data.dims();
	dim_vector dims_q = query.dims();
	
	const int k = args(2).int_value();
	const int d = dims_d(0); // dimension of points
	const int nd = dims_d(1);
	const int nq = dims_q(1); // number of query points
	// octave_stdout<<"There are "<<nd<<" data points and "<<nq<<" query points"<<
	// " of dimension "<<d<<"\n";
	
	ANNkd_tree		*the_tree;	// Search structure

	// ANNkd_tree expects an ANNpointArray which is a dimensionless array
	// of type ANNcoord** ie usually double**
	ANNpointArray data_pts = new ANNpoint[nd];
    
	// annAllocPts would allocate new space for the coordinates
	// But we can save memory by backing the ANNpointArray with
	// the original octave matrix
	for (int i = 0; i < nd; i++) {
		data_pts[i] = &(data_as_double_array[i*d]);
	}

	the_tree = new ANNkd_tree(data_pts , nd, d);
	
    // allocate space for outputs
	// NB use of dim_vector is required for int32NDArray
	dim_vector dims_output (2);
	dims_output(0)=k;dims_output(1)=nq;
	Matrix dists (dims_output);
	int32NDArray idx (dims_output);
    
	ANNidx * pidx = (ANNidx*) idx.fortran_vec();
    ANNdist* pdist= (ANNdist*) dists.fortran_vec();
    ANNpoint pp   = (ANNpoint) query.fortran_vec();
    
    for (int j = 0 ; j < nq ; j++ ) {
        the_tree->annkSearch(pp, k, pidx, pdist, eps);
        pp += d;
        pidx += k;
        pdist += k;
    }

	// clean up
	delete [] data_pts;
	delete the_tree;

	// Return results
	octave_value_list rvals;
	if(nargout>0)
		rvals.append(idx);
	if(nargout>1)
		rvals.append(dists);
		
    return rvals;
}

static bool
any_bad_argument(const octave_value_list& args)
{
    
	if (args.length()!=4)
    {
        error("annoct: requires three arguments");
        return true;
    }

	if (!args(0).is_real_matrix())
    {
        error("annoct: expecting data points (arg 1) to be a real matrix");
        return true;
    }

	if (!args(1).is_real_matrix())
    {
        error("annoct: expecting query points (arg 2) to be a real matrix");
        return true;
    }

    if (args(0).rows() != args(1).rows())
    {
        error("annoct: dimension of query points must be same as data points");
        return true;
    }

    if (!args(2).is_real_scalar())
    {
        error("annoct: k (arg 3) must be a real scalar.");
        return true;
    }

    if (args(2).scalar_value() < 1.0)
    {
        error("annoct: k (arg 3) must be > 1");
        return true;
    }

    if (floor(args(2).scalar_value()) != args(2).scalar_value())
    {
        error("annoct: k (arg 3) must be an integer.");
        return true;
    }

    if (args(3).scalar_value() < 0.0)
    {
        error("annoct: eps (arg 4) must be > 0.0");
        return true;
    }

    return false;
}