function [ sat_frac ] = kSAT_demo_clauses()

%ksat demo for n literals, m clauses, w width of clause, Q prob distrib

%n=20000
%m=100000
%w=5;
%Q=[0,  0.5, 0,0, .5,  0]
%T=50;
%fname='demo_formula_5_2.cnf';


n=500;
m=100000;
w=4;
Q=[0, .4, .3, .2,.1]
T=50;
densities = [.2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5];
fname='demo_formula_4_3.cnf';

fprintf('Solving planted kSAT for n= %d \n',n);
fprintf('literals, m= %d \n',m);
fprintf('clauses, w= %d \n', w);
fprintf('width of clause, distribution Q= %d ,',Q);
fprintf('and T= %d ',T,'iterations \n');

path(path,'../');
path(path,'../subroutines/');
path(path,'../data/');
path(path,'../demos/');
path(path,'../main/');  

dc = dist_complexity2(Q);

fprintf('This distribution has complexity %d \n', dc);
fprintf('Generating random assignment... \n');

sigma = 2*round(rand(n,1))-1;
sd=size(densities);

for i= 1:sd(2)

    fprintf('Generating random formula...\n');
    mm(i)=round(m*densities(i));
    genkSAT(sigma, n, mm(i), w, Q, fname );
    fprintf('Generating file of clauses...\n');
    cor(i)=kSATalg_clauses( fname, sigma, Q, T,2 );

end
plot(mm/(n^(dc/2)),cor);
xlabel('clause density: m/n^{r/2}');
ylabel('correlation');
title(['Plot of correlation as a function of the clause density']);
legend('nb');
saveas(gcf,'clauses_corr.pdf');

end
