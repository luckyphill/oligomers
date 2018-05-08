function dMdx = MnUBpcmb(x,M,p)
    % p is a structure with the parameters
    Mwsum = 0;
    Msum = 0;
    for i=1:p.n
        Msum = Msum + M(i); %only the end units can cause a break
        Mwsum = Mwsum + i * M(i); %every unit can cause a break
    end
    %Msum = Mwsum;
    dMdx=zeros(2*p.n,1);
    dMdx(1)=M(p.n+1);
    dMdx(p.n+1)=p.K1*M(1)/(p.K2+M(1));
    i=1;
    for j=i+1:p.n
        dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*Msum*M(j);
    end

    for i=2:p.n
        dMdx(i)     = M(p.n+i);
        dMdx(p.n+i)   = p.K6*Msum*(i-1)*M(i)*i^(1/3); 
        for j=i+1:p.n
            dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*Msum*M(j)*i^(1/3);
        end
    end
end