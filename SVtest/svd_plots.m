function [ ] = svd_plots()


% Written by Laura Florescu (lara.florescu@gmail.com) and Will Perkins (william.perkins@gmail.com)
% Please write us with any questions or comments!
  h=figure;
n1 = [1000];
n2 = [100000];
delta = 0.2;


p1=(n1*n2)^(-1/2)*log(n1)*[0.01 0.03 0.04 0.05 0.09 0.1 0.15 0.2 0.25]
pp =(1+0.1)*(delta-1)^(-2)*(n1*n2)^(-1/2)*[0.01 0.05 0.07 0.1 0.15 0.2 0.25 0.3 0.35 0.4]
p2=(n1)^(-2/3)*(n2)^(-1/3)*[0.01 0.05 0.08 0.1 0.15 0.2]
p3=(n1)^(-2/3)*(n2)^(-1/3)*log(n1)*[0.01 0.05 0.08 0.1 0.15 0.2 0.25]

ppp=[p1,pp,p2,p3];
ppp=sort(ppp);
sn=size(ppp);
sn;
trials=10;

for i= 1:sn(2)
   
	 p(i) = delta*ppp(i);
         q(i) = (2-delta)*ppp(i);
         for j=1:trials
		 [cor(i,j),cor2(i,j),cor3(i,j)] = randSparseRect(n1,n2,p(i),q(i));
end
end

plot(ppp,sum(cor,2)/trials,ppp,sum(cor2,2)/trials,ppp,sum(cor3,2)/trials);
xlabel('p(n1,n2)');
ylabel('correlation');
title(['Plot of correlation as a function of p(n1,n2), n1= ', num2str(n1), ', n2=', num2str(n2), ', delta=', num2str(delta)]);
legend('v','dd','ess');
saveTightFigure(h,'plot19.pdf');

end
