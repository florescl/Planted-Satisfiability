function [ sat_frac ] = kSAT_demo_clauses()

% Planted k-SAT demo for different clause distirbutions, showing the performance at varying clause densities

% Written by Laura Florescu (lara.florescu@gmail.com) and Will Perkins (william.perkins@gmail.com)
% Please write us with any questions or comments!

opt.distribution=4;

if (opt.distribution==1)
	% 5-SAT distribution with distribution complexity 2
	n=20000
	m=100000
	w=5;
	Q=[0,  0.5, 0,0, .5,  0]
	T=50;
	densities = [.05 .1 .15 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5];
	fname='demo_formula_5_2.cnf';
	plotname='ksat_densities_5_2.pdf';
	plotlabel='clause density: m/n';
end

if (opt.distribution==2)
	% 4-SAT distirbution with distribution complexity 3
	n=500;
	m=100000;
	w=4;
	Q=[0, .4, .3, .2,.1]
	T=50;
	densities = [.05 .1 .15 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5];
	fname='demo_formula_4_3.cnf';
	plotname='ksat_densities_4_3.pdf';
	plotlabel='clause density: m/n^{3/2}';
end

if (opt.distribution==3)
	% 5-SAT distirbution with distribution complexity 4
	n=250;
	m=300000;
	w=5;
	Q=[0, .25, .25, .25,.25, 0]
	T=50;
	densities = [.05 .1 .15 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5];
	fname='demo_formula_5_4.cnf';
	plotname='ksat_densities_5_4.pdf';
	plotlabel='clause density: m/n^2';
end

if (opt.distribution==4)
	% 3-SAT distribution with distribution complexity 2
	n=20000
	m=400000
	w=3;
	Q=[0,  0.6, .3, .1]
	T=50;
	densities = [ .5 .6 .7 .8 .9 1 1.1 1.2 1.3];
	fname='demo_formula_3_2.cnf';
	plotname='ksat_densities_3_2.pdf';
	plotlabel='clause density: m/n';
end


fprintf('%s\n',strcat('Solving planted kSAT for n= ',num2str(n)));
%fprintf('%s\n','clauses, w= %d \n', w);
fprintf('%s\n',strcat('Clause distribution Q= ',num2str(Q)));
fprintf('%s\n',strcat('and number of power iterations= ', num2str(T)));


path(path,'subroutines/');


dc = dist_complexity2(Q);

fprintf('%s\n',strcat('This distribution has complexity=', num2str(dc)));
fprintf('Generating random assignment... \n');

sigma = 2*round(rand(n,1))-1;
sd=size(densities);
sd(2)

for i= 1:sd(2)
	tic;
    fprintf('Generating random formula...\n');
    mm(i)=round(m*densities(i));
    genkSAT(sigma, n, mm(i), w, Q, fname );
    toc
    fprintf('Solving k-SAT instance...\n');
    tic;
    cor(i)=kSATalg_clauses( fname, sigma, Q, T,1 );
    toc

end
plot(mm/(n^(dc/2)),cor);
xlabel(plotlabel);
ylabel('correlation');
title(['Plot of correlation as a function of the clause density']);
plotlegend=strcat('n= ', num2str(n), ' k= ', num2str(w), ' dist complexity= ', num2str(dc));
legend(plotlegend);
saveas(gcf,plotname);

end
