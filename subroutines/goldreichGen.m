function [ M ] = goldreichGen( sigma, w, fHandle, m )
%
ss=size(sigma);
n=ss(1);

V=floor(rand(m,w)*n)+1;

X=sigma(V);
M= [V fHandle(X)];

end

