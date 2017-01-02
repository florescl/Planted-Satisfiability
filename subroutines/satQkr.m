function [ Q ] = satQkr( k, r, t )
%outputs a prob vector Q for a k-SAT distribution of complexity r with a
%fully satisfying assignment.
   
path(path,'../');
path(path,'../subroutines/');
path(path,'../data/');
path(path,'../demos/');
path(path,'../main/');    
path(path,'formulas/');    

A=zeros(r+2,k+1);

A(1,:) = ones(1,k+1);
A(2,:) = zeros(1,k+1);
A(2,1)=1;
B= zeros(r+2,1);
B(1)=1;
B(r+1)=t;
for j=1:r
    for s=0:k
        for i=0:s
            for l=0:s-i
                A(j+2,s+1)=A(j+2,s+1)+ (-1)^i*nchoosek(j,i)*nchoosek(k-j,l);
            end
        end 
    end
end

Q=solve(A,B);

end

