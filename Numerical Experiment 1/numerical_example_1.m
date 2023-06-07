% Numerical Experiment 1

% Reference:
%   Paper   = Fast random vector transform within Wiener filtering paradigm. (Submitted paper - 2023)
%   Authors = Soto-Quiros, Pablo and Torokhti, Anatoli

clc; clear
warning ('off','all');

%%%% Step 1: Create samples %%%%

m=100; p=3; s=30;

[X,Y]=createSamples(m,p,s);

%%%% Step 2: Compute the covariance matrices using samples %%%%

m=size(X,1); s=size(X,2); p=size(X,3);
Exy=zeros(m,m,p); Eyy=zeros(m,m,p);

for i=1:p
    Exy(:,:,i)=(1/s)*(X(:,:,i)*(Y(:,:,i))');
    Eyy(:,:,i)=(1/s)*(Y(:,:,i)*(Y(:,:,i))');
end

%%%% Step 3: Choose value of constant alpha %%%%

alpha=1e-12;

%%%% Step 4: Comuputing the multi-filtering transform using fast implementation and original formula %%%%

tic; F1=mft(Exy,Eyy,alpha); t1=toc;
tic; [F2,A,B]=mftNaive(Exy,Eyy); t2=toc;

%%%% Step 5: Display the results obtained  %%%%

disp(['Time to compute multi-filtering transform using fast implementation = ',num2str(t1), ' seconds'])
disp(['Time to compute multi-filtering transform using original formula = ',num2str(t2), ' seconds'])
disp('.')
erApprox=norm(A-F1*B,'fro');
erExact=norm(A-F2*B,'fro');

error_estimaton=erApprox-erExact;
disp(['Diference between errors given by fast implementation and original formula = ', num2str(error_estimaton)])
disp('.')

speedup=t2/t1;
percent_difference=100*(t2-t1)/t2;
disp(['Speedup of the multi-filtering transform using fast implementation  = ', num2str(speedup)])
disp(['The multi-filtering transform using fast implementation  is ', num2str(percent_difference),'% faster than using the original formula'])
