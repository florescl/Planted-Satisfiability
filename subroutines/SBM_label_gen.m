function [M] = SBM_label_gen(sigma, p, q,m1,m2 )

%Generates a random graph on n vertices with a bipartition given by sigma.
%Probability of interior edges is p, crossing edges is q
%m1 is prob of +1 on interior edge, m2 prob on crossing edge

s=size(sigma);
n=s(1);
count=cumsum(ones(n,1));
sigma2=[sigma count];
sigma2=sortrows(sigma2,1);
sig_perm=sigma2(:,2);


tic;

len_vec(2)= (sum(sigma)+n)/2;
len_vec(1)= n-len_vec(2);


M=sparse(0,n);

for i=1:2
    R=sparse(len_vec(i),0);
    
    for j=1:2
        if (i==j)
            T1=sparseRand(len_vec(i),len_vec(j),m1*p);
            T2=sparseRand(len_vec(i),len_vec(j),(1-m1)*p);
            T=T1-T2;
        else
            T1=sparseRand(len_vec(i),len_vec(j),m2*q);
            T2=sparseRand(len_vec(i),len_vec(j),(1-m2)*q);
            T=T1-T2;
        end
     R =[R T];
    end
M= [M; R];
end

M=triu(M)+triu(M)';
M=M-diag(diag(M));
M(sig_perm,sig_perm)=M;

end
