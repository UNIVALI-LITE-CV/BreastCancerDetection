function [K, L] = ripley_colorado(locs,dist,box)
% http://www.colorado.edu/geography/class_homepages/geog_4023_s07/labs/lab10/RipleysK.m
%
% RipleysK: Calculate K statistic
%
% K = RipleysK(locs,dist, box,method) calculates G, the K statistic at each
% distance for the data with x-y coordinates given by locs, and the
% bounding rectangle given by box=[minX maxX minY maxY].
% If method=0, no edge correction is applied.
% If method=1, points are only used if they are at least h units away from
% the edge.
%
% Note: The L statistic may be calculated from the K statistic as follows:
%   L = sqrt(K/pi)-h;
%

[N,k] = size(locs);
if k~=2, error('locs must have two columns'); end

DIST = pdist2(locs,locs,'euclidean');

K = sum(sum(DIST(2:end,:)<dist))/N;
lambda = N/((box(2)-box(1))*(box(4)-box(3)));
K = K/lambda;
L = sqrt(K/pi)-dist;

end