function [ dc ] = dist_complexity2( Q )

% calculates the distribution complexity of the planting distribution Q, where Q(i) is the fraction of clauses
% with i satisfied literals under the planted assignment sigma


ss=size(Q);
k=ss(2)-1;


S=[];
D=[1:2^k]-1;
D=D';
B = 2*rem(floor(D*pow2(-(k-1):0)),2)-1;

PR=(sum(B,2)+k)/2;
for i=1:2^k
PR(i)=Q(PR(i)+1)/nchoosek(k,PR(i));
end

done=0;

i=1;

while done<1
P=pick(1:k,i,'');
for j=1:nchoosek(k,i)   
    sm=sum(predX(B(:,P(j,:))).*PR);
    
    if (abs(sm)>.001)
        S=[S; P(j,:)];
        done=1;
        r=i;
    end
end


if i==k
    done=1;
end
i=i+1;
end


dc=r;
end

