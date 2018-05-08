function dMdx = MnUBacmb(x,M,p)
    % p is a structure with the parameters
    dMdx=zeros(2*p.n,1);
    dMdx(1)=M(p.n+1);
    dMdx(p.n+1)=p.K1*M(1)/(p.K2+M(1));
    i=1;
    for j=p.q+1:p.n
        dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*M(j);
    end

    for i=2:p.q-1
        dMdx(i)     = M(p.n+i);
        for j=i+p.q:p.n
            dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*M(j)*i^(1/3);
        end
    end
    for i=p.q:p.n
        dMdx(i)     = M(p.n+i);
        dMdx(p.n+i)   = 2*(i-p.q)*p.K6*M(i)*i^(1/3);
        for j=i+p.q:p.n
            dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*M(j)*i^(1/3);
        end
        for j=i+1:p.n
            dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*M(j)*i^(1/3);
        end
    end
end