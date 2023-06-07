function Y=sqrtmSVD(A)
    [U,S,V]=svd(A);
    constante=max(size(A))*eps(max(max(S)));
    I=S>constante;
    Snew=S.*I;
    Y=U*sqrt(Snew)*V';
end