function c = MnUBmsmb_make_coeff(n,K6)

c=zeros(n);
c(n,n-1)   = ratio(n,n-1);



for i = n-2:-1:2
    c(n,i) = -ratio(n,i) * c(n,i+1);
end



%c(n-1,n-2) = ratio(n-1,n-2) * c(n,n-1);

for k=n-1:-1:3
    frontpart = sprintf('C(%d,%d) = ',k,k-1);
    backpart = sprintf(' ratio(%d,%d) * [',k,k-1);
    backpartnumbers = sprintf(' %.2f * [',ratio(k,k-1));
    for j=n:-1:k+1
        c(k,k-1) = c(k,k-1) + ratio(k,k-1)*c(j,k);
        backpart = [backpart, sprintf('C(%d,%d) + ',j,k)];
        backpartnumbers = [backpartnumbers, sprintf('%.1f + ',c(j,k))];
    end
    %fprintf('%s\n',[frontpart,backpart]);
    %fprintf('%s\n',[frontpart,backpartnumbers]);
    for i = k-2:-1:2
        c(k,i) = -ratio(k,i) * c(k,i+1);
        %fprintf('C(%d,%d) = -ratio(%d,%d) *  C(%d,%d)\n',k,i,k,i,k,i+1);
        %fprintf('C(%d,%d) = %.2f * %.2f\n',k,i,-ratio(k,i),c(k,i+1));
    end
end

for j=3:n
    c(2,1) = c(2,1) + c(j,2);
end

for k=3:n
    for j=k+1:n
        c(k,1) = c(k,1) + c(j,k);
    end
    for j=k-1:n
        c(k,1) = c(k,1) + c(k,j);
    end
end





end

function r = ratio(k,i)
    r = i^(1/3) / (k^(1/3) - i^(1/3));
    %r = 3*k/(k-i)-2;
end