Written by Laura Florescu (lara.florescu@gmail.com) and Will Perkins (william.perkins@gmail.com)
Please write us with any questions or comments!


This folder includes Matlab code for solving planted satisfiability problems and 
stochastic block models.  

There are two main demo functions:

1. kSAT_demo_clauses
Simply type 'ksat_demo_clauses' into Matlab from the main folder directory.

The code generates planted k-SAT formulas at varying edge densities, finds an assignment 
with a power iteration algorithm (described below) , then measures the correlation
of the found assignment with the planted assignment.

The plot shows correlation against clause density, scaled by n^{r/2} where r is the 
distribution complexity of the planting distribution Q.  The plot is output as a pdf file.

We've given 3 examples of planted k-SAT distributions with different complexities. To 
change the distribution simply change the line 
opt.distribution=1;
to
opt.distribution=2;
or
opt.distribution=3;

Option 1 gives a 5-SAT distribution with complexity 2.
Option 2 gives a 4-SAT distribution with complexity 3.
Option 3 gives a 5-SAT distribution with complexity 4.

2. kSAT_demo_iterations
Type 'ksat_demo_iterations' into Matlab from the main folder directory.

This demo generates a single planted k-SAT instance and then plots the correlation
of an evolving assignment with the true planted assignment for each iteration of 
power iteration.  We compare two different algorithms, one based on an adjacency matrix
and the other on a non-backtracking matrix.

The same 3 clause distributions are given as options. 


Algorithms:

The full details of the algorithms used are the subject of a paper in progress, but
the main idea is to apply optimal algorithms for various stochastic block models from
the work 
Decelle, Krzakala, Moore, Zdeborova: 'Asymptotic analysis of the stochastic block model for modular networks and its
algorithmic applications' http://arxiv.org/pdf/1109.3041.pdf
to a new reduction from k-SAT instances and hypergraphs to graphs.  
The reduction is inspired by previous reductions from planted CSP's to graphs in the works 
Bogdonov, Qiao: 'On the Security of Goldreich's One-Way Function'
http://www.cse.cuhk.edu.hk/~andrejb/pubs/goldreichowf.pdf
and 
Feldman, Perkins, Vempala: 'Subsampled Power Iteration: a Unified Algorithm for Block Models
and Planted CSP’s'  http://arxiv.org/pdf/1407.2774.pdf 

The distribution complexity parameter is defined in 
Feldman, Perkins, Vempala: 'On the Complexity of Random Satisfiability Problems
with Planted Solutions' http://arxiv.org/pdf/1311.4821v4.pdf
where it is shown that all efficient statistical algorithms for planted k-SAT fail
below n^{r/2} clauses.