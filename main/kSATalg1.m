function [ ] = kSATalg1( fname, rect, sigma, Q, T, meth )

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

%t=[1:T/5+1]';

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
    
else

    if(dc==2)
        ML=double(clausestoedges(F,n,m,w,dc));
        C=sparse(ML(:,1),ML(:,2),1);
        size(C)
        C=C+C';
        binary_corr_adj = SBM_plot(sigma,rect,2*n,2,s,T,1,2)
        binary_corr_nb = SBM_plot(sigma,rect,2*n,2,s,T,2,2)
        %size(binary_corr_adj)
        %size(binary_corr_nb)
        %size(t)
        
        t=1:size(binary_corr_adj);
        f=figure;
        plot(t,binary_corr_adj,t,binary_corr_nb)
        %, t, binary_corr_nb)
        xlabel('t iterations');
        ylabel('correlation');
        title(['Plot of correlation as a function of power ' ...
               'iterations']);
        legend('adj','nb');
        saveas(gcf,'iterations_corr.pdf')
        
    else
        
        ML=clausestoedges(F,n,m,w,dc);
        binary_corr_adj= SBM_plot(sigma,rect,2*n,2,s,T,1,2);
        binary_corr_nb= SBM_plot(sigma,rect,2*n,2,s,T,2,2);

        t=1:size(binary_corr_adj);

        plot(t,binary_corr_adj,t,binary_corr_nb)
        xlabel('t iterations');
        ylabel('correlation');
        title(['Plot of correlation as a function of power ' ...
               'iterations']);
        legend('adj','nb');
        saveas(gcf,'iterations_corr.pdf')

             
    end

end
end