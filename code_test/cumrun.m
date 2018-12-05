    clear all
    n = 10;
    M = [1:n]';	
    I = (2:n);
    tic;
    N = cumsum(M(I),'reverse')';
    toc
    tic;
    sum(triu(ones(length(I)),0).*M(I)',2)';
    toc
    tic;
    sum(triu(repmat(M(I)',length(I),1)),2);
    toc