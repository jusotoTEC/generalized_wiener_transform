function [X,Y]=createSamples(m,p,s)

    %Creat samples such that sum_{i=1}^p(E_{yi,yi}) is singular

    iterMax=100000;
    for k=1:iterMax    
        Suma=zeros(m,m);
        X=zeros(m,s,p);
        N=zeros(m,s,p);
        Y=zeros(m,s,p);
        for i=1:p
            X(:,:,i)=randn(m,s);
            N(:,:,i)=randn(m,s);
            Y(:,:,i)=X(:,:,i)+N(:,:,i);
            Eyiyi=(1/s)*(Y(:,:,i)*(Y(:,:,i))');
            Suma=Suma+Eyiyi;
        end
        if rank(Suma)<m
            break
        end    
    end
    
end