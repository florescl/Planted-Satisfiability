function [ sat_frac ] = kSAT_demo()

%ksat demo for n literals, m clauses, w width of clause, Q prob distrib

%n=20000
%m=100000
%w=5;
%Q=[0,  0.5, 0,0, .5,  0]
%T=50;
%fname='demo_formula_5_2.cnf';


n=500;
m=110000;
w=4;
Q=[0, .4, .3, .2,.1]
T=50;
fname='demo_formula_4_3.cnf';

fprintf('Solving planted kSAT for n= %d ',n);
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

fprintf('Generating random formula...\n');

genkSAT(sigma, n, m, w, Q, fname );
fprintf('Generating file of clauses...\n');

kSATalg1( fname, sigma, Q, T,2 );


end