function dMdx = MnUBpcob(x,M,p)
    % p is a structure with the parameters
    %Msum = sum(M);
    dMdx=zeros(2*p.n,1);
    dMdx(1)=M(p.n+1);
    
    Mwsum = 0;
    Msum = 0;
    for i=1:p.n
        Msum = Msum + M(i); %only the end units can cause a break
        Mwsum = Mwsum + i * M(i); %every unit can cause a break
    end

    % This checks the parameter p.proportion to see if only end units cause breakage or the whole oligomer can
    % unit = proportional to the number of olgomer units, weight = proportional to the weight (size) of the oligomers
    if strcmp(p.proportion, 'unit')
        Mwsum = Msum;
    end
    
    % With the second lines uncommented we have every unit causes a break
    % With the first lines uncommented we have only end units causing a break
    % With the if statement above, we only need the second line and a valid p.proportion value
    for i=1:p.n-1
        dMdx(i) = M(p.n+i);
        %dMdx(p.n+i) = p.K1 * i^(1/3)*M(i)/(p.K2+Msum) + p.K6 * Msum * i^(1/3) * (i-1) *M(i);
        dMdx(p.n+i) = p.K1 * i^(1/3)*M(i)/(p.K2+Msum) + p.K6 * Mwsum * i^(1/3) * (i-1) *M(i);
        for j=i+1:p.n
            %dMdx(p.n+i) = dMdx(p.n+i)  - 2 * p.K6 * Msum * i^(1/3) * M(j);
            dMdx(p.n+i) = dMdx(p.n+i)  - 2 * p.K6 * Mwsum * i^(1/3) * M(j);
        end
    end
    dMdx(p.n) = M(2*p.n);
    %dMdx(2*p.n)=p.K1 * i^(1/3)*M(p.n)/(p.K2+Msum) + p.K6 * Msum * p.n^(1/3) * (p.n-1) *M(p.n);
    dMdx(2*p.n)=p.K1 * i^(1/3)*M(p.n)/(p.K2+Msum) + p.K6 * Mwsum * p.n^(1/3) * (p.n-1) *M(p.n);
    
end