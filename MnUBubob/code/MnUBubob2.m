function dMdx = MnUBubob2(x,M,p)
    % M must be a column vector
    % p is a structure with the parameters

    % M is a vector of size 2*p.n,1
    % the first p.n components are M
    % the second p.n components are dM/dx

    % dMdx is a vector of size 2*p.n,1n 
    % the first p.n components are dM/dx
    % the second p.n components are d^2M/dx^2

    % The if statement is because vectorising is considerably faster for large
    % p.n, but considerably slower for small p.n

    if p.n >= 16
        % vectorised
        dMdx=zeros(size(M));
        dMdx(1)=M(p.n+1);
        
        Msum = sum(M(1:p.n));
        J = 1:p.n;
        dMdx(J) = M(J+p.n);
        
        I = (1:p.n)';
        N = triu(ones(p.n),1).*M(I)';
        
        dMdx(p.n+I) = p.K1 .* I.^(1/3).*M(I)./(p.K2+Msum) + p.K6 .* I.^(1/3) .* (I-1) .*M(I) - 2 .* p.K6 .* I.^(1/3) .* sum(N,2);
    else
        % Dumb for loops
        dMdx=zeros(2*p.n,1);
        dMdx(1)=M(p.n+1);
        Msum=0;
        
        for i=1:p.n
            Msum = Msum + M(i);
        end
        
        for i=1:p.n-1
            dMdx(i) = M(p.n+i);
            dMdx(p.n+i) = p.K1 * i^(1/3)*M(i)/(p.K2+Msum) + p.K6 * i^(1/3) * (i-1) *M(i);
            for j=i+1:p.n
                dMdx(p.n+i) = dMdx(p.n+i)  - 2 * p.K6 * i^(1/3) * M(j);
            end
        end
        dMdx(p.n) = M(2*p.n);
        dMdx(2*p.n)=p.K1 * p.n^(1/3)*M(p.n)/(p.K2+Msum) + p.K6 * p.n^(1/3) * (p.n-1) *M(p.n);
    end

end