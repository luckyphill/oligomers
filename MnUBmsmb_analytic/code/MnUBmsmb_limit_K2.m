function [signal_gradient,varargout] = MnUBmsmb_limit_K2(n,K1,K2,K3,K6)
	% This attempts to analytically solve the msmb system
	C = MnUBmsmb_coeff_limit(n,K1,K2,K6);
	N = 1:1:n;
	lambda = sqrt(2 * K6 * N.^(1/3));
	lambda(1) = sqrt(K1/K2);

	x = linspace(0, 1, 1000);
	M = zeros(1,1000);

	for k=2:n
		if sech(lambda(1))/lambda(1) < 1e-100 % If the coefficient for the monomer is extremely small, then remove that part to avoid NaNs or Infs due to non-uniform convergence
			Mtemp = C(k,1)*(K3.*sech(lambda(k)).*sinh(lambda(k).*(x-1))./lambda(k));
		else	
			Mtemp = C(k,1)*(K3.*sech(lambda(k)).*sinh(lambda(k).*(x-1))./lambda(k) - K3.*sech(lambda(1)).*sinh(lambda(1).*(x-1))./lambda(1));
		end
        M = M + Mtemp;
    end

    %signal_gradient =  M ./ (K2 + M);
    signal_gradient = M/K2;
    varargout{1} = M;

end