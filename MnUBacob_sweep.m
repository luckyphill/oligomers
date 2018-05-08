function MnUBacob_sweep(n,K3,K6,q)
	p.n=n;
	p.n_numerical = n;
	p.K3=K3;
	p.K6=K6;
	p.q=q;
	p.signal = 'single';

	r.p1_min = -8;
	r.p1_max = 8;
	r.p2_min = -8;
	r.p2_max = 8;

	res = 40;

	filename = parameter_space(@MnUBacob, @oligomer_BC, res, p,r);

	plot_parameter_space(filename);

end