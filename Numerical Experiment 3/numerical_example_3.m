% Numerical Experiment 3

% Reference:
%   Paper   = Fast random vector transform within Wiener filtering paradigm. (Submitted paper - 2023)
%   Authors = Soto-Quiros, Pablo and Torokhti, Anatoli

clc; clear; close all
warning ('off','all');

%%%% Step 1: Choose data %%%%

load('sample_n_200.mat','X','N','Y')

%%%% Step 2: Compute the covariance matrices using samples %%%%

m=size(X,1); s=size(X,2); p=size(X,3);
Exx=zeros(m,m,p); Exy=zeros(m,m,p); Eyy=zeros(m,m,p);

for i=1:p
    Exx(:,:,i)=(1/s)*(X(:,:,i)*(X(:,:,i))');
    Exy(:,:,i)=(1/s)*(X(:,:,i)*(Y(:,:,i))');
    Eyy(:,:,i)=(1/s)*(Y(:,:,i)*(Y(:,:,i))');
end


%%%% Step 3: Compute the error estimation, with different values of alpha, using Theorem 4 %%%%

eAlpha=[];

rangeAlpha=10.^-(0:15); % We consider alpha = 10^0, 10^-1, 10^-2, ..., 10^-15.

for alpha=rangeAlpha

    partialSum1=0;
    A=[]; B=[];

    for i=1:p
      Exyi=Exy(:,:,i);
      EyyiSqrtm=sqrtmSVD(Eyy(:,:,i));   %We compute the matrix square root, using the SVD approach
      A=[A Exyi*pinvSVD(EyyiSqrtm)];    %We compute the pseudoinverse, using the SVD approach
      B=[B EyyiSqrtm];
      b1=trace(Exx(:,:,i)-Exyi*pinvSVD(Eyy(:,:,i))*Exyi');
      partialSum1=partialSum1+b1;
    end

    [~,S,V]=svd(B);
    r=rank(B);
    Sr=S(1:r,1:r);

    matrixD_alpha=eye(m*p);
    matrixD_alpha(1:r,1:r)=1-(Sr(i,i).^2./(Sr(i,i).^2+alpha));

    errorAlpha=abs(partialSum1+norm(A*V*matrixD_alpha,'fro')^2);
    eAlpha=[eAlpha errorAlpha];

    display(['Error estimation with alpha = ' num2str(alpha), ' is ', num2str(errorAlpha)])

end

loglog(rangeAlpha,eAlpha,'.-','MarkerSize',12) % Plot alpha vrs error estimation
xlabel('\alpha')
ylabel('Error estimation')
grid on


%%%% Step 3: Compute the exact error, using Theorem 2 %%%%

partialSum2=0;

for i=1:p
  partialSum2=partialSum2+trace(Exx(:,:,i));
end
x=1;
errorExact=partialSum2-trace(A*pinvSVD(B)*B*A');

display(['Exact error is ', num2str(errorExact)])

