% Set the oligomer second derivatives
    clear all
    n = 5;
    M = [1:n]'

    I = (2:n);
    N = cumsum(M(I),'reverse');
    Y(I) = (I-1).*M(I).*I - 2*N.*I;
    %Y(n) = (n-1).*M(n).*n;

    L = triu(ones(n-1),1).*M(I)
    Z(I) = (I-1).*M(I).*I - 2*sum(L').*I;

    for i=2:n
        X(i)   = (i-1)*M(i)*i; 
        % X(i)   = X(i)- 2*sum(M((i+1):n))*i;
        for j=i+1:n
            X(i)   = X(i) - 2*M(j)*i;
        end
    end

    X
    Y
    Z
    X-Y
    X-Z