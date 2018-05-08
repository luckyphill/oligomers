function MnUBpcobas_sweep(n,K3,K6)
	p.n=n;
	p.n_numerical = n;
	p.K3=K3;
	p.K6=K6;
	p.signal = 'multiple';

	r.p1_min = -8;
	r.p1_max = 8;
	r.p2_min = -8;
	r.p2_max = 8;

	res = 40;

	filename = parameter_space(@MnUBpcob, @oligomer_BC, res, p, r);

	plot_parameter_space(filename);

end