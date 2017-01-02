function [cor ] = kSATalg_clauses( fname, sigma, Q, T, meth )

%compressed2 orthogonal iteration for rectangular matrix comgin from the
%k-SAT formula from fname of width k, dist. complexity r

path(path,'../');
path(path,'../subroutines/');
path(path,'../data/');
path(path,'../demos/');
path(path,'../main/');    

s=5;
ss=size(Q);
w=ss(2)-1;

dc=dist_complexity2(Q);

tic;
[F, n, m]=cnfIn(fname,w);
toc

if (dc==1)
	%Performs majority vote on variables if the distribution complexity is 1
    FV=abs(double(F));
    FS=sign(F);
    sv=zeros(n,1);
    for j=1:n
       sv(j)=double(sign(sum(sum(double(FS).*double(FV==j))))); 
    end
    tau_vec=sv;
    sat_frac = satFrac(F, sigma,n);
    %binary_corr=
    
else

    if(dc==2)
        ML=double(clausestoedges(F,n,m,w,dc));
        C=sparse(ML(:,1),ML(:,2),1);
        size(C)
        C=C+C';
        tau_vec=SBMrectLabel(C,2*n,2,s,T,meth,1);
        %binary_corr_adj = SBM_plot(sigma,C,2*n,2,s,T,1,1)
        %binary_corr_nb = SBM_plot(sigma,C,2*n,2,s,T,2,1)
        %size(binary_corr_adj)
        %size(binary_corr_nb)
        %size(t)
        cor=max(binary_correlation([sigma; - sigma],tau_vec));
        
        
    else
        
        ML=clausestoedges(F,n,m,w,dc);
        tau_vec=SBMrectLabel(ML,2*n,2,s,T,meth,2);
        cor=max(binary_correlation([sigma; - sigma],tau_vec));
             
    end
    %for i=2:s
    %   sf2(1,i-1)=satFrac(F,sign(tau_vec(1:n,i)),n);
    %   sf2(2,i-1)=satFrac(F,-sign(tau_vec(1:n,i)),n);
    %end
    %sat_frac=max(sf2);
    %sat_frac=max(max(sf2));
    %frac_advantage=(sat_frac-(1-2^(-w)))*2^w
end
end
