function [F,A,B]=mftNaive(Exy,Eyy)
    [m,n,p]=size(Eyy);
    A=zeros(m,n*p); B=zeros(n,n*p);
    for i=1:p
        EyiyiSqrt=sqrtmSVD(Eyy(:,:,i));
        EyiyiSqrtPinv=pinv(EyiyiSqrt);
        A(:,(i-1)*n+1:i*n)=Exy(:,:,i)*EyiyiSqrtPinv;
        B(:,(i-1)*n+1:i*n)=EyiyiSqrt;
    end
    F=A*pinv(B);
end

function X=sqrtmSVD(A)
    [U,S,V]=svd(A);
    X=U*sqrt(S)*V';
end