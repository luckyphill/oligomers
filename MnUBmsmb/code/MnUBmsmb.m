function dMdx = MnUBmsmb(x,M,p)
	% p is a structure with the parameters
    % This ODE is scaled by the largest constant in C
    % need to reconsider how lambda is used - i.e. the calculation of lambda
    C1 = p.C(:,1)/p.C_max;
    dMdx = [0,0];
    dMdx(1) = M(2);
   
    
    K=(2:p.n);
    dMdx(2) = p.K1*M(1)./(p.K2 + p.C_max * M(1)) + sum(C1(K)'.*p.K3*(p.n^(-2/3)).*sech(p.lambda(K)).*sinh(p.lambda(K).*(x-1))./p.lambda(K));
    % dMdx(2) = p.K1*M(1)./(p.K2 + p.C_max * M(1));
    % for k=2:p.n
    %     dMdx(2) = dMdx(2) + C1(k)*p.K3*sech(p.lambda(k))*sinh(p.lambda(k)*(x-1))/p.lambda(k);
    % end
    
end