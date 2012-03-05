function [idx, dst2] = annoctsearch (data, query, k, epsl, asm)
% Copyright (C)  Gregory Jefferis
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; If not, see <http://www.gnu.org/licenses/>.

% -*- texinfo -*-
% @deftypefn {Function File} [idx, dst2] = annoctsearch (data, query, k, epsl, asm)
% Returns indices (and squared distance) of k nearest neighbours of query in data
%
% Usage:
% [idx, dst2] = annoctsearch (data, query, k, epsl, asm)
% 
% Inputs:
% data  - d x N data points (if not single, will be converted with a warning)
% query - d x M query points (if not single, will be converted with a warning)
% k     - number of nearest neighbours to return
% epsl  - search radius for approximate search
% asm   - allow self matches (true by default)
%
% Outputs:
% idx   - 1-indexed indices of matching points in data
% dst2  - squared distance from query points to neighbours in data
%         (nb k neighbours are returned in ascending order of distance)
% @end deftypefn
%
% Author:  Gregory Jefferis <jefferis@gmail.com>, shamelessly hacking Shai Bagon's code

if nargin <= 2
	usage('[idx, dst2] = annoctsearch (data, query, k, [epsl, asm])')
end

if ~isnumeric(data)
    error('annoctsearch: data must be numeric 2D matrix');
end

if ndims(data) > 2 || numel(data) == 0
    error('annoctsearch: Data must be 2D');
end

[dim npts] = size(data);

% TODO convert data to be of supported class if required
if ~strcmp(class(data),'single')
	warning('converting data matrix to single')
	data=single(data);
end

if ~strcmp(class(query),'single')
	warning('converting query matrix to single')
	query=single(query);
end

if nargin <= 3
	epsl=0.0;
end

if nargin <= 4
    asm = true;
end

if ~asm
    k = k+1;
end

[idx dst2] = annoct(data, query, k, epsl);

% remove self matches if we don't want them 
if ~asm
    gsm = dst2(1,:)==0;
    dst2(1:end-1,gsm) = dst2(2:end,gsm);
    idx(1:end-1,gsm) = idx(2:end,gsm);
    dst2(end,:) = [];
    idx(end,:) = [];
end

idx = idx + 1; % fix zero indexing (C style) from ANN

end

%%!test fail ('annoctsearch([1, 1],[1, 1],1)', 'ann:open Data must be 2D');
%!shared pts
%! pts=single([1:20;2:21;22:-1:3]);
%
%!test % 2 arg 
%! [idx,dst2]=annoctsearch(pts,pts,2);
%! assert (idx,int32([1:20;2 1 2 3 4 7 8 7 8 9 12 13 14 13 14 17 18 19 20 19]))
%! assert (dst2,single(repmat([0;3],1,20)))
%
%!test % 1 arg
%! idx=annoctsearch(pts,pts,2);
%! assert (idx,int32([1:20;2 1 2 3 4 7 8 7 8 9 12 13 14 13 14 17 18 19 20 19]))
