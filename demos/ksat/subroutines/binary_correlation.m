function [ cor_vec ] = binary_correlation( sigma, tau_vec )
%Checks the correlation of each column of tau with the binary assignment
%given by sigma.

% Written by Laura Florescu (lara.florescu@gmail.com) and Will Perkins (william.perkins@gmail.com)
% Please write us with any questions or comments!

s_tau=size(tau_vec);
s_sigma=size(sigma);

n=s_sigma(1);
if s_tau(1) ~= n
    error('sizes do not match');
end

s=s_tau(2);

cor_vec=abs(tau_vec'*sigma)/double(n);



end

