function F=mft(Exy,Eyy)
    N=sum(Exy,3);
    M=sum(Eyy,3);
    F=N/M;    
end