function MnUBmsmb_gradient(n,K1,K2,K3,K6)
	
	p.n=n;
	p.n_numerical = 1;
	p.K1=K1;
	p.K2=K2;
	p.K3=K3;
	p.K6=K6;
	p.signal = 'monomer';
	p.C = MnUBmsmb_make_coeff(n,K6);
	N = 1:1:n;
	p.lambda = sqrt(2 * K6 * N.^(1/3));

	p.L = 1;
	p.xsteps = 1000;

	[signal, M, B] = generate_gradient(@MnUBmsmb,@MnUBmsmb_BC,p);
	x = linspace(0,p.L,p.xsteps);
	eta = calculate_eta(signal,p)
	figure();
	plot(x,M(1,:))
	figure();
	plot(x,B(1,:))
	%figure();
	%plot(x,M(1,:))

end