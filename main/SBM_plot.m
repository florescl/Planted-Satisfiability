function[ binary_corr ] = SBM_plot( sigma, EL,n, k,s, T,meth,square )
%SBM using orthogonal iteration
% T is the number of iterations
% s is the number of vectors to track

opt.mod = 1;
opt.method=meth;
%method=1 is orthogonal iteration
%method=2 is iteration using the backtracking derived matrix B
%method=3 is for the Bethe Hessian

opt.square=square;
%square=1 for square matrices
%square=2 for rectangular

path(path,'../');
path(path,'../subroutines/');
path(path,'../data/');
path(path,'../demos/');
path(path,'../main/');
binary_corr = zeros(T/opt.mod+1,1);
binary_corr_adj = zeros(T/opt.mod+1,1);
binary_corr_nb = zeros(T/opt.mod+1,1);

if (opt.square==1)
    C=EL;
else
    CL=compressLabelEdgeList(EL);
    C=sparse(CL(:,1),CL(:,2),CL(:,3));
    ss=size(C);    
    %ensure that matrix has n rows
    C(n,ss(2))=0;
end


if (opt.method==1 | opt.method==3)
    X=round(rand(n,s))*2-1;
else
    X1 = round(rand(n,s))*2-1;
    X2 = round(rand(n,s))*2-1;
    XX = [X1; X2];
end
    
D=sum(C,2);
%size(D)
%n
DDiag=sparse(1:n,1:n,D,n,n,n);
DS=repmat(D,1,s);


if (opt.method==3)
	avg_degree=sum(D)/n;
	%lambda=sqrt(avg_degree);
	lambda = sqrt(mean(D.^2)/mean(D)-1);
        % lambda^2-1
	if(opt.square==1)
		BH1= (lambda^2-1)*speye(n,n)+lambda*C + DDiag;
		BH2= (lambda^2-1)*speye(n,n)-lambda*C + DDiag;
	else	
	end
end

tic;

if (opt.square==1)
        
   if (opt.method==1)
        for i=1:T
            DDS=X.*DS;
            X=C*X;
            X=C*X;
            X=X-DDS;
            X=orth(X);
            if(mod(i,opt.mod) == 0)
                tau_vec_adj=sign(X);
                
                binary_corr(i/opt.mod+1) = max(binary_correlation([sigma; ...
                                    -sigma], tau_vec_adj));
            end
        end
   end
   if (opt.method==2)
        Z=sparse([],[],[],n,n);
        SD = spdiags(D,0,Z);
        B1 = [Z SD-speye(n)];
        B2 = [-speye(n) C];
        B = [B1;B2];
        for i=1:T
            XX=B*XX;
            XX=B*XX;
            XX=orth(XX);
            if(mod(i,opt.mod) == 0)
                tau_vec_nb = sign(XX(n+1:2*n,:));
                %size(tau_vec_nb)
                %size(sigma)
                binary_corr(i/opt.mod+1) = max(binary_correlation([sigma; ...
                                    -sigma],tau_vec_nb));
            end 
        end
    end
    if(opt.method==3)
    	%for i=1:T
    	%X=BH2*X;
    	%X=BH2*X;
    	%X=orth(X);
    	%end
    	[X1, ev]=eigs(BH1,2,'sa');	
    	[X2, ev]=eigs(BH2,2,'sa');
        X=[X1 X2];
    end
    
    
else


   if (opt.method==1)
       for i=1:T
           DDS=X.*DS;
           Y=C'*X;
           X=C*Y;
           X=X-DDS;
           X=orth(X);
           if(mod(i,opt.mod)== 0)
               tau_vec_adj=sign(X);
               
               binary_corr(i/opt.mod+1) = max(binary_correlation([sigma; ...
                                   - sigma], tau_vec_adj));
           end
       end
   end
   if (opt.method==2)
        for i=1:T
            oldX1=XX(1:n,:);
            oldX2=XX(n+1:2*n,:);
            X1 = oldX2.*(DS-1);
            Y2 = C'*oldX2;
            X2= -oldX1 +C*Y2-oldX2.*DS;
            XX=[X1; X2];
            XX=orth(XX);
            if(mod(i,opt.mod) == 0)
                tau_vec_nb = sign(XX(n+1:2*n,:));
                binary_corr(i/opt.mod+1) = max(binary_correlation([sigma; ...
                                    -sigma],tau_vec_nb));
            end
            
        end
    
   end
   if(opt.method==3)
        X1=round(rand(n,s))*2-1;
        X2=round(rand(n,s))*2-1;
       for i=1:T
           Y1=C'*X1;
           X1=(lambda^2-1)*X1+lambda*C*Y1 +(1-lambda)*DS.*X1;
           ev1=norm(X1(:,1));
           X1=orth(X1);
       end
       for i=1:T
           Y2=C'*X2;
           X2=(lambda^2-1)*X2-lambda*C*Y2 +(1+lambda)*DS.*X2;
           ev2=norm(X2(:,1));
           X2=orth(X2);
       end
       
       ev=max(ev1,ev2);
       
       X1=round(rand(n,s))*2-1;
       X2=round(rand(n,s))*2-1;
       
       for i=1:T
           Y1=C'*X1;
           X1=(lambda^2-1-ev)*X1+lambda*C*Y1 +(1-lambda)*DS.*X1;
           X1=orth(X1);
       end
       for i=1:T
           Y2=C'*X2;
           X2=(lambda^2-1-ev)*X2-lambda*C*Y2 +(1+lambda)*DS.*X2;
           X2=orth(X2);
       end
       
        X=[X1 X2];
        
   end

end
toc


% Return the generated vectors.  If k=2, then vectors are rounded by sign.
% If k > 2, then vectors are left as reals.  

if  (opt.method==1 | opt.method==3)
    if(k==2)
        tau_vec=sign(X);
    else
        tau_vec=X;
    end
    
else
    if (k==2)
        tau_vec=sign(XX(n+1:2*n,:));
    else
        tau_vec=XX(n+1:2*n,:);
    end
    
end
%binary_corr_adj
%binary_corr_nb

end