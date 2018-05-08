function dMdx = MnUBmsob(x,M,p)
    % p is a structure with the parameters
    dMdx=zeros(2*p.n,1);
    dMdx(1)=M(p.n+1);
    Msum=0;
    
    for i=1:p.n
        Msum = Msum + M(i);
    end
    
    for i=2:p.n-1
        dMdx(i) = M(p.n+i);
        dMdx(p.n+i) = p.K1 * i^(1/3)*M(i)/(p.K2+Msum) + 2 * p.K6 * i^(1/3) * (M(i) - M(i+1));
        
    end
    
    i=1;
    dMdx(i) = M(p.n+i);
    dMdx(p.n+i) = p.K1 * M(i)/(p.K2+Msum);
    for j=i+1:p.n
        dMdx(p.n+i) = dMdx(p.n+i)  - 2 * p.K6 * M(j);
    end
    
    dMdx(p.n) = M(2*p.n);
    dMdx(2*p.n)=p.K1 * i^(1/3)*M(p.n)/(p.K2+Msum) + p.K6 * p.n^(1/3) * M(p.n);
    
end