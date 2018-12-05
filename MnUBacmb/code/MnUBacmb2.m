function dMdx = MnUBacmb2(x,M,p)
    % p is a structure with the parameters
    

    if p.n >24 % Vectorised way for large p.n
        dMdx = zeros(size(M));

        % Set the first derivatives
        I = 1:p.n;
        dMdx(I)=M(p.n+I);
       
        % Monomer equation
        dMdx(p.n+1) = p.K1*M(1)/(p.K2+M(1)) - 2*p.K6*sum(M(p.q+1:p.n));

        J = (2:p.q-1)';
        K = ((2+p.q):p.n)';
        % N = triu(ones(length(J),length(K)),0).*M(K)';
        N = triu(repmat(M(K)',length(J),1),0);
        dMdx(p.n+J)   = - 2*p.K6.*sum(N,2).*J.^(1/3);


        I = (p.q:p.n)';
        J = (2*p.q:p.n)';
        K = ((p.q+1):p.n)';
        % N = triu(ones(length(I),length(J)),0).*M(J)';
        % L = triu(ones(length(I),length(K)),0).*M(K)';
        N = triu(repmat(M(J)',length(I),1),0);
        L = triu(repmat(M(K)',length(I),1),0);
        dMdx(p.n+I)   = 2*(I-p.q).*p.K6.*M(I).*I.^(1/3) - 2*p.K6*sum(N,2).*I.^(1/3) - 2*p.K6*sum(L,2).*I.^(1/3);
    else
        % Dumb for loop method
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



end