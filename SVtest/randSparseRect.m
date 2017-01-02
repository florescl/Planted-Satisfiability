function [v,dd] = randSparseRect( n,m,p,q)
%generates a random n x m graph with k-way partition, with prob of p inside
%partition, q across partition
n=2*round(n/2);
m=2*round(m/2);

M=sparse(0,m);

for i=1:2
    R=sparse(n/2,0);
    
   for j=1:2
    if (i==j)
        T=sparseRand(n/2, m/2,p);
    else
        T=sparseRand(n/2, m/2,q);
   end
    R=[R T];
   end
 M= [M; R];
end

u = [ones(n/2,1); -ones(n/2,1)];

A= M*M';
A;
[V, D]= svds(A);
D;
VS=sign(V);

Cor= VS'*u/n;
v=max(abs(Cor));

dv=diag(A);
dm=diag(dv);
AD=A-dm;
[V2, D2]= svds(AD);
D2;
VS2=sign(V2);
Co2r= VS2'*u/n;
dd=max(abs(Co2r));


v,dd;



end
