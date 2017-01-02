function [ M ] = compressEdgeList2( ML )
%remove isolated vertices and the ones with one edge


s=size(ML);
L=s(1);

ML=sortrows(ML,2);

M=zeros(L,3);

M(:,1)=ML(:,1);

k=0;
m1=0;
m2=-1;
for i=1:L
    if (ML(i,2)==m1)
    M(i,2)=k;
    M(i,3)=1;
    M(i-1,3)=1;
    else
        k=k+1;
        M(i,2)=k;
        m1=ML(i,2);
    end
end

TDel=M(:,3)==0;
M(TDel,:)=[];



end
