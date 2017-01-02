function [ sat_frac ] = satFrac( F, sigma, n )
%Given k-SAT formula and assignment returns fraction of clauses satisfied.
%
ss=size(F);
m=ss(1);

MV=abs(F);

MS=sign(F);

SAT=sigma(MV).*double(MS);

sat_frac=(1+sum(max(SAT')')/m)/2;


end

