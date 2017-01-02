function [ Y ] = pred2( X )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

%Y= mod(X(:,1)+X(:,2)+X(:,3)+X(:,4).*X(:,5),2);
Y= 2*mod((sum(X,2)+1)/2,2)-1;

end

