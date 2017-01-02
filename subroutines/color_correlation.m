function [ r ] = color_correlation( sigma, tau_vec, k )
%Checks the correlation of a k-means partitioning of tau_vec with the
%partition given by sigma into k parts.  

 warning('off','stats:kmeans:FailedToConvergeRep');

s_tau=size(tau_vec);
s_sigma=size(sigma);

n=s_sigma(1);
if s_tau(1) ~= n
    error('sizes do not match');
end

s2=[ sigma cumsum(ones(n,1))];
s2= sortrows(s2);

V=kmeans(tau_vec(:,2:s_tau(2)),k);

V=V(s2(:,2));


if (k < 9)

T=factorial(k);

P=perms(1:k);
r=0;

for i=1:T
  v=P(i,:);
  q=zeros(1,0);
  for j=1:k
      z=repmat(v(:,j),1,n/k);
      q=[q z];
  end
  q=q';
  b=V==q;
  r= max(r,sum(b)/n);
end

else
    
    
end

r=(r-1/k)/(1-1/k);


%cor_vec=abs(tau_vec'*sigma)/n;



end
