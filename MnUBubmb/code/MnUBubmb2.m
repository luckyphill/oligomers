function dMdx = MnUBubmb2(x,M,p)
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
    if p.n >= 13
        J = 1:p.n;
        dMdx = zeros(size(M));

        % Set the first derivatives
        dMdx(J) = M(J+p.n);

        I = (2:p.n)';
        % Set the monomer second derivative
        dMdx(p.n+1)   = p.K1*M(1)/(p.K2+M(1))- 2*p.K6*sum(M(I));
        % Set the oligomer second derivatives
        
        % N = triu(ones(p.n-1),1).*M(I)'; % This makes an upper triangular matrix that mirrors the "triangular" for loop below 
        N = sum(triu(repmat(M(I)',p.n-1,1),1),2);
        dMdx(p.n+I) = p.K6.*(I-1).*M(I).*I.^(1/3) - 2*p.K6*N.*I.^(1/3);
    else


        % for i=2:p.n
        %     dMdx(p.n+i)   = p.K6*(i-1)*M(i)*i^(1/3); 
        %     %dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*sum(M((i+1):p.n))*i^(1/3);
        %     for j=i+1:p.n
        %         dMdx(p.n+i)   = dMdx(p.n+i) - 2*p.K6*M(j)*i^(1/3);
        %     end
        % end
        dMdx=zeros(2*p.n,1);
        dMdx(1)=M(p.n+1);
        dMdx(p.n+1)=p.K1*M(1)/(p.K2+M(1));
        i=1;
        for j=i+1:p.n
            dMdx(p.n+i)   = dMdx(p.n+i)- 2*p.K6*M(j);
        end

        for i=2:p.n
            dMdx(i)     = M(p.n+i);
            dMdx(p.n+i)   = p.K6*(i-1)*M(i)*i^(1/3); 
            for j=i+1:p.n
                dMdx(p.n+i)   = dMdx(p.n+i) - 2*p.K6*M(j)*i^(1/3);
            end
        end
    end

    

end