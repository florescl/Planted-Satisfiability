function [ ] = kSATalg1( fname, sigma, Q, T, meth )

%compressed2 orthogonal iteration for rectangular matrix comgin from the
%k-SAT formula from fname of width k, dist. complexity r

% Written by Laura Florescu (lara.florescu@gmail.com) and Will Perkins (william.perkins@gmail.com)
% Please write us with any questions or comments!

s=5;
ss=size(Q);
w=ss(2)-1;

dc=dist_complexity2(Q);

%t=[1:T/5+1]';


[F, n, m]=cnfIn(fname,w);


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
        size(C);
        C=C+C';
        tic;
        fprintf('Solving instance with power iteration...\n');
        binary_corr_adj = SBM_plot(sigma,C,2*n,2,s,T,1,1);
        toc
        tic;
        fprintf('Solving instance with non-backtracking power iteration...\n');
        binary_corr_nb = SBM_plot(sigma,C,2*n,2,s,T,2,1);
        toc
        %size(binary_corr_adj)
        %size(binary_corr_nb)
        %size(t)
        
        t=1:size(binary_corr_adj);
        f=figure;
        plot(t,binary_corr_adj,t,binary_corr_nb)
        %, t, binary_corr_nb)
        xlabel('t iterations');
        ylabel('correlation');
        title([strcat('Plot of correlation as a function of power iterations (n=',num2str(n),')')]);
        legend('adj','nb');
        legend('adj','nb');
        plotname=strcat('iterations_corr_', num2str(w),'_',num2str(dc),'.pdf');
        saveas(gcf,plotname)
        
    else
        
        ML=clausestoedges(F,n,m,w,dc);
        tic;
        fprintf('Solving instance with power iteration...\n');
        binary_corr_adj= SBM_plot(sigma,ML,2*n,2,s,T,1,2);
        toc
        tic;
        fprintf('Solving instance with non-backtracking power iteration...\n');
        binary_corr_nb= SBM_plot(sigma,ML,2*n,2,s,T,2,2);
        toc

        t=1:size(binary_corr_adj);

        plot(t,binary_corr_adj,t,binary_corr_nb)
        xlabel('t iterations');
        ylabel('correlation');
        title([strcat('Plot of correlation as a function of power iterations (n=',num2str(n),')')]);
        legend('adj','nb');
        plotname=strcat('iterations_corr_', num2str(w),'_',num2str(dc),'.pdf');
        saveas(gcf,plotname)

             
    end

end
end
