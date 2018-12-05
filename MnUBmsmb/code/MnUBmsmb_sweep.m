function MnUBmsmb_sweep(n,K3,K6,res)
	p.n=n;
	p.n_numerical = 1;
	p.K3=K3;
	p.K6=K6;
	p.signal = 'monomer';
	p.C = MnUBmsmb_make_coeff(n,K6);
	p.C_max = 1;%max(abs(p.C(:,1)));
	N = 1:1:n;
	p.lambda = sqrt(2 * K6 * N.^(1/3));

	r.p1_min = -8;
	r.p1_max = 8;
	r.p2_min = -8;
	r.p2_max = 8;

	filename = parameter_space(@MnUBmsmb, @MnUBmsmb_BC, res, p,r);

	plot_parameter_space(filename);

end