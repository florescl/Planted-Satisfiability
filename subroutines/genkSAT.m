function [  ] = genkSAT( sigma, n, m, w, Q, fname )
%Creates a .cnf file with a planted w-SAT distribution with assignment
%sigma, n vars, m clauses, w - width of clause, and planting function Q, where Q(i) fraction of
%clauses have i satisfied literals under sigma
tic;


ss=size(sigma);
if ss(1)~=n
    error('genkSAT', 'sigma not of length n')
end

if abs(sum(Q)-1)>.01
    error('genkSAT', 'Q not prob distribution')
end

Falses=w-randsample(w+1,m,true,Q)+1;
M = zeros(m,w);
Vars= floor(rand(m,w)*n)+1;
signs=ones(m,w);

for i=1:w
    rv=rand(m,1);
    fv = double(rv<Falses/(w-i+1));
    signs(:,i)=1-2*fv;
    Falses=Falses-fv;
end

Vars=Vars.*sigma(Vars);


M=Vars.*signs;
M = [M zeros(m,1)];

fileID=fopen(fname,'w');
fprintf(fileID, '%s\t %u\t %u\n', 'p cnf ', n, m);
dlmwrite(fname,M, 'delimiter', '\t', '-append')
fclose(fileID);
toc
end

