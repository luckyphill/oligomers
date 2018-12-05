function dMdx = MnUBmsob2(x,M,p)
    % p is a structure with the parameters
    dMdx=zeros(size(M));
    
    % Set the first derivatives
    I = 1:p.n;
    dMdx(I)=M(p.n+I);
    
    Msum = sum(M(I));

    
    dMdx(p.n+1) = p.K1 * M(1)/(p.K2+Msum) - 2 * p.K6 * sum(M(2:p.n));

    J = (2:p.n-1)';
    dMdx(p.n+J) = p.K1 * J.^(1/3).*M(J)./(p.K2+Msum) + 2 * p.K6 * J.^(1/3) .* (M(J) - M(J+1));

    dMdx(2*p.n) = p.K1 * p.n^(1/3)*M(p.n)/(p.K2+Msum) + 2 * p.K6 * p.n^(1/3) * M(p.n);
    
    % for i=2:p.n-1
    %     dMdx(p.n+i) = p.K1 * i^(1/3)*M(i)/(p.K2+Msum) + 2 * p.K6 * i^(1/3) * (M(i) - M(i+1));
        
    % end
    
    % for j=i+1:p.n
    %     dMdx(p.n+i) = dMdx(p.n+i)  - 2 * p.K6 * M(j);
    % end
    
    
    
end