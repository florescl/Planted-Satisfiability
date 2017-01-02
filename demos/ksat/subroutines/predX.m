function [ Y ] = predX( X )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
ss=size(X);
k=ss(2);
%Y= mod(X(:,1)+X(:,2)+X(:,3)+X(:,4).*X(:,5),2);
Y= 2*mod((sum(X,2)+mod(k,2))/2,2)-1;

end

