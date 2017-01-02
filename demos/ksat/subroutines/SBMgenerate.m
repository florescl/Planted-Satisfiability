function [M] = SBMgenerate(sigma, p, q, k )

%Generates a random graph on n vertices with a bipartition given by sigma.
%Probability of interior edges is p, crossing edges is q

s=size(sigma);
n=s(1);
count=cumsum(ones(n,1));
sigma2=[sigma count];
sigma2=sortrows(sigma2,1);
sig_perm=sigma2(:,2);


tic;

if (k >2)
for i=1:k
    len_vec(i)=sum(sigma(:,1)==i);
end
else
len_vec(2)= (sum(sigma)+n)/2;
len_vec(1)= n-len_vec(2);
end

M=sparse(0,n);

for i=1:k
    R=sparse(len_vec(i),0);
    
    for j=1:k
        if (i==j)
            T=sparseRand(len_vec(i),len_vec(j),p);
        else
            T=sparseRand(len_vec(i),len_vec(j),q);
        end
     R =[R T];
    end
M= [M; R];
end

M=triu(M)+triu(M)';
M=M-diag(diag(M));
M(sig_perm,sig_perm)=M;

end
