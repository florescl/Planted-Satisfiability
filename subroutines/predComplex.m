function [ S, r ] = predComplex( fHandle, k )

S=[];
D=[1:2^k]-1;
D=D';
B = 2*rem(floor(D*pow2(-(k-1):0)),2)-1;

done=0;

i=1;

while done<1
P=pick(1:k,i,'');
for j=1:nchoosek(k,i)
    predX(B(:,P(j,:)));
    fHandle(B);
    sm=sum(predX(B(:,P(j,:))).*fHandle(B));
    if (sm~=0)
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



end

