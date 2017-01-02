function [ Y ] = pred1( X )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

%Y= mod(X(:,1)+X(:,2)+X(:,3)+X(:,4).*X(:,5),2);
Y= X(:,1).*X(:,2).*X(:,3).*(2 -(X(:,4)-1).*(X(:,5)-1)    )/2;

end

