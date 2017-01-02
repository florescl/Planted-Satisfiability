function [ sat_frac ] = kSAT_demo_iterations()

% Planted k-SAT demo for different planted distributions, showing the progress of two variants of power iteration

% Written by Laura Florescu (lara.florescu@gmail.com) and Will Perkins (william.perkins@gmail.com)
% Please write us with any questions or comments!




opt.distribution=1;

if (opt.distribution==1)
	% 5-SAT distribution with distribution complexity 2
	n=40000;
	m=200000;
	w=5;
	Q=[0,  0.5, 0,0, .5,  0];
	T=40;
	fname='demo_formula_5_2.cnf';
	plotname='ksat_densities_5_2.pdf';
	plotlabel='clause density: m/n';
end

if (opt.distribution==2)
	% 4-SAT distirbution with distribution complexity 3
	n=1500;
	m=450000;
	w=4;
	Q=[0, .4, .3, .2,.1];
	T=50;
	fname='demo_formula_4_3.cnf';
	plotname='ksat_densities_4_3.pdf';
	plotlabel='clause density: m/n^{3/2}';
end

if (opt.distribution==3)
	% 5-SAT distirbution with distribution complexity 4
	n=400;
	m=960000;
	w=5;
	Q=[0, .25, .25, .25,.25, 0];
	T=40;
	fname='demo_formula_5_4.cnf';
	plotname='ksat_densities_5_4.pdf';
	plotlabel='clause density: m/n^2';
end


fprintf('%s\n',strcat('Solving planted kSAT for n= ',num2str(n)));
fprintf('%s\n','number of clauses =', num2str(m));
fprintf('%s\n',strcat('Clause distribution Q= ',num2str(Q)));
%fprintf('%s\n',strcat('and number of power iterations= ', num2str(T)));



path(path,'subroutines/');


dc = dist_complexity2(Q);

fprintf('%s\n', strcat('This distribution has complexity= ', num2str(dc)));


fprintf('Generating random assignment... \n');

sigma = 2*round(rand(n,1))-1;
tic;
fprintf('Generating random formula...\n');

genkSAT(sigma, n, m, w, Q, fname );
toc

kSATalg1( fname, sigma, Q, T,2 );


end