function MUB_sweep(K3,res)
	p.n=1;
	p.n_numerical = 1;
	p.K3=K3;
	p.signal = 'single';

	r.p1_min = -8;
	r.p1_max = 8;
	r.p2_min = -8;
	r.p2_max = 8;

	filename = parameter_space(@MUB, @oligomer_BC, res, p, r);

	plot_parameter_space(filename);

end