function [ M ] = sparseRand( n,m,p )
if p<.01
    M=sprand(n,m,p)>0;
else
    M=rand(n,m)<p;
    M=sparse(M);
end

M= double(M);
end
