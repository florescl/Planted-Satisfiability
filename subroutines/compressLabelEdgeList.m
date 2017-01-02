function [ M ] = compressLabelEdgeList( EL )
%remove isolated vertices and the ones with one edge


s=size(EL);
L=s(1);

EL=sortrows(EL,2);

M=zeros(L,4);

M(:,1)=EL(:,1);
M(:,3)=EL(:,3);

k=0;
m1=0;
m2=-1;
for i=1:L
    if (EL(i,2)==m1)
    M(i,2)=k;
    M(i,4)=1;
    M(i-1,4)=1;
    else
        k=k+1;
        M(i,2)=k;
        m1=EL(i,2);
    end
end

TDel=M(:,4)==0;
M(TDel,:)=[];



end