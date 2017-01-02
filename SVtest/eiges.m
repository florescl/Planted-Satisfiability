function [] = eiges()

n=5000;
m=5000000;
h=figure;    
p1=(n*m)^(-1/2)*log(n);
p2=n^(-2/3)*m^(-1/3);
p3=n^(-2/3)*m^(-1/3)*log(n);

d0=0.5; 
d1=1;

A1=rand_eig(n,m,p1*d0,p1*(2-d0));
B1=rand_eig(n,m,p1*d1,p1*(2-d1));

A2=rand_eig(n,m,p2*d0,p2*(2-d0));
B2=rand_eig(n,m,p2*d1,p2*(2-d1));

A3=rand_eig(n,m,p2*d0,p2*(2-d0));
B3=rand_eig(n,m,p3*d1,p3*(2-d1));

plot(imag(A1)+0.2,real(A1)/norm(real(A1)),'g*',imag(B1)+0.2,real(B1)/ ...
     norm(real(B1)),'bo',imag(A2)+0.3,real(A2)/norm(real(A2)),'g*',imag(B2)+0.3,real(B2)/norm(real(B2)),'bo',imag(A3)+0.4,real(A3)/norm(real(A3)),'g*',imag(B3)+0.4,real(B3)/norm(real(B3)),'bo') 
text(0.21,0.315,' \leftarrow eigs at p1')
text(0.31, 0.315, '\leftarrow eigs at p2')
text(0.41,0.315, '\leftarrow eigs at p3')
xlabel('p1=(n1*n2)\^(-1/2)*log(n1), p2=n1\^(-2/3)*n2\^(-2/3), p3=n1\^(-2/3)*n2\^(-1/3)*log(n1)');
ylim([0.29 max(real(A2)/norm(real(A2)))+0.005])
xlim([0.15 0.45])
ylabel('top 10 normalized eigenvalues');
title(['Plot of the top eigenvalues of MM^T for delta=0.5 and delta=1 for the various regimes p(n1,n2)']);
legend('delta=0.5 (planted)','delta=1 (random)');
saveTightFigure(h,'alleigs5.pdf')


end
