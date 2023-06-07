clc; clear;

n=200; s=30; p=6;

iterMax=100000;

for k=1:iterMax
    k
    Suma=zeros(n,n);
    X=zeros(n,s,p);
    N=zeros(n,s,p);
    Y=zeros(n,s,p);
    for i=1:p
        X(:,:,i)=randn(n,s);
        N(:,:,i)=randn(n,s);
        Y(:,:,i)=X(:,:,i)+N(:,:,i);
        Eyiyi=(1/s)*(Y(:,:,i)*(Y(:,:,i))');
        Suma=Suma+Eyiyi;
    end
    if rank(Suma)<n
        text=['sample_n_',num2str(n),'.mat'];
        save(text,'X','N','Y')
        break
    end

end

