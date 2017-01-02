function [ M, n, m ] = cnfIn( fname, k )
%Imports a .cnf file of a k-SAT formula into a matrix with rows indexed by
%clauses, and entries indicating the literals

fileID=fopen(fname);
Line1=textscan(fileID, '%s %s %u %u',1);
n=double(Line1{3});
m=double(Line1{4});

form=repmat('%d',1,k+1);
%form=strcat('%s',form)


 C2=textscan(fileID, form,'CommentStyle','c');
 
 M=double(cell2mat(C2(1:k)));





fclose(fileID);

end

