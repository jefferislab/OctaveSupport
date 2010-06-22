#include <octave/oct.h>
#include <math.h>    // math routines
#include "ANN.h"     // ANN library header
 
static bool
	any_bad_argument(const octave_value_list& args);
 
DEFUN_DLD(matpow, args, nargout,
           "Find k nearest neighbours for each query point from target ")
{
	if (any_bad_argument(args))
		return octave_value_list();

	const int nargin = args.length ();
	const int k = args(2).int_value();

    Matrix data(args(0).matrix_value());
    Matrix query(args(1).matrix_value());

    return octave_value_list();
}

static bool
any_bad_argument(const octave_value_list& args)
{
    
	if (args.length()!=3)
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

    if (floor(args(1).scalar_value()) != args(1).scalar_value())
    {
        error("annoct: k (arg 3) must be an integer.");
        return true;
    }

    return false;
}