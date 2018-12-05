function c = MnUBmsmb_coeff_limit(n,K1,K2,K6)

c=zeros(n);
c(n,n-1)   = ratio(n,n-1,K1,K2,K6);



for i = n-2:-1:1
    c(n,i) = -ratio(n,i,K1,K2,K6) * c(n,i+1);
end



%c(n-1,n-2) = ratio(n-1,n-2) * c(n,n-1);

for k=n-1:-1:2
    frontpart = sprintf('C(%d,%d) = ',k,k-1);
    backpart = sprintf(' ratio(%d,%d) * [',k,k-1);
    backpartnumbers = sprintf(' %.2f * [',ratio(k,k-1,K1,K2,K6));
    for j=n:-1:k+1
        c(k,k-1) = c(k,k-1) + ratio(k,k-1,K1,K2,K6)*c(j,k);
        backpart = [backpart, sprintf('C(%d,%d) + ',j,k)];
        backpartnumbers = [backpartnumbers, sprintf('%.1f + ',c(j,k))];
    end
    %fprintf('%s\n',[frontpart,backpart]);
    %fprintf('%s\n',[frontpart,backpartnumbers]);
    for i = k-2:-1:1
        c(k,i) = -ratio(k,i,K1,K2,K6) * c(k,i+1);
        %fprintf('C(%d,%d) = -ratio(%d,%d) *  C(%d,%d)\n',k,i,k,i,k,i+1);
        %fprintf('C(%d,%d) = %.2f * %.2f\n',k,i,-ratio(k,i),c(k,i+1));
    end
end

end

function r = ratio(k,i,K1,K2,K6)
    r = i^(1/3) / (k^(1/3) - i^(1/3));
    if i == 1
        r = K1/K2 / (2*K6*k^(1/3) - K1/K2);
    end
    %r = 3*k/(k-i)-2;
end