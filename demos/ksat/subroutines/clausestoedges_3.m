function [ edgelist ] = clausestoedges_3(M, n, m, k, r)

% converts a matrix of clauses of a CNF formula into a list of edges in a graph.  If r=2 the graph is indexed by literals and literals.
% if r>2, then one side of the graph is indexed by literals, the other side by (r-1)-tuples of literals

% Written by Laura Florescu (lara.florescu@gmail.com) and Will Perkins (william.perkins@gmail.com)
% Please write us with any questions or comments!    
    

 
    
n=double(n);
edgelist = zeros(0,3);

%convert to all positive
%sort each clause
%then go through all of them and add the entries in the edge list

v = [1 2; 1 3];

%convert negative literals i to positive number n+i
M=abs(M)+(1-sign(M))/2*n;
ss=size(M);
L=ss(1);

%a=1:2*n;
%counts=[a,histc(M(:),a)]


for a=1:2
    string = v(a,:);
    Mv=M(:,string);
    for l=1:1   
        Mvr=Mv;
        Mvr(:,l)=[];
        Mvr=sort(Mvr,2);           
        val2=zeros(m,1);
        for t=1:r-1
            val2=val2+double((2*n)^(t-1)*Mvr(:,t));
        end
        row = [Mv(:,l),val2,ones(L,1)];
        edgelist=[row;edgelist];
    end
end
edgelist;

end