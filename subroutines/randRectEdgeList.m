function [ M ] = randRectEdgeList( n,m,a,b,edges )
%create edge list for a bipartite, 2 block graph, with edges num of edges,
%in proportion a:b interior:crossing

n=2*round(n/2);
m=2*round(m/2);
edges=2*round(edges/2);


M=zeros(edges,2);

l1=round(edges*a/(a+b));
l1=2*round(l1/2);
l2=edges-l1;


x=[floor(rand(edges/2,1)*n/2)+1; floor(rand(edges/2,1)*n/2)+n/2+1];
M(:,1)=x;



y=[floor(rand(l1/2,1)*m/2)+1; floor(rand(l2/2,1)*m/2)+m/2+1; floor(rand(l2/2,1)*m/2)+1; floor(rand(l1/2,1)*m/2)+m/2+1 ];
M(:,2)=y;

end