function [v,dd] = randSparseRect( n,m,p,q)

u=rand(n,1);
uu=rand(m,1);

u=u';
uu=uu';

M = uu'*u;
A=M*M';
size(A);
A=A+wgn(m,m,0.5);

A;
[V, D]= svds(A);
D;
VS=sign(V);

Cor= VS'*uu'/n;
v=max(abs(Cor));

dv=diag(A);
dm=diag(dv);
AD=A-dm;
[V2, D2]= svds(AD);
D2;
VS2=sign(V2);
Co2r= VS2'*uu'/n;
dd=max(abs(Co2r));

%S=sum(A,2);
%B=A;
%B(1:n+1:n*n)=S;
%[V3,D3] = svds(B*B');
%VS3=sign(V3);
%size(VS3');
%co3r=VS3'*uu/n;
%ess = max(abs(co3r));

v,dd;



end
