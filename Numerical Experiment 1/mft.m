function F=mft(Exy,Eyy,alpha)
    n=size(Eyy,1);
    N=sum(Exy,3);
    M=sum(Eyy,3)+alpha*eye(n);
    F=N/M; 
end