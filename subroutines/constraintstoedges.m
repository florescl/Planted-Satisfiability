function [ edgelist ] = constraintstoedges(M, n, fHandle, w)
%n=double(n);
edgelist = zeros(0,3);

ss=size(M);

m=ss(1);

[S r]=predComplex(fHandle,w);

sss=size(S);
L=sss(1);

for a=1:L
    string = S(a,:);
    Mv=M(:,string);
    for l=1:r   
        Mvr=Mv;
        Mvr(:,l)=[];
        Mvr=sort(Mvr,2);
        val2=zeros(m,1);
        for t=1:r-1
            val2=val2+double((2*n)^(t-1)*Mvr(:,t));
        end
        row = [Mv(:,l),val2 , M(:,w+1)];
        edgelist=[row;edgelist];
    end
end
   
end