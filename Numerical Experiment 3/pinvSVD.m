function X=pinvSVD(A)

    [U,S,V]=svd(A);
    constante=max(size(A))*eps(max(max(S)));
    Snew=(zeros(size(S)))';
    for i=1:min(size(S))
        if S(i,i)>constante
            Snew(i,i)=1/S(i,i);
        end
    end
    X=V*Snew*U';
end