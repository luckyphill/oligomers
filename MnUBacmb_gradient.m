function MnUBacmb_gradient(n,K1,K2,K3,K6,q)
	
	p.n=n;
	p.n_numerical = n;
	p.K1=K1;
	p.K2=K2;
	p.K3=K3;
	p.K6=K6;
	p.q = q;
	p.signal = 'monomer';

	p.L = 1;
	p.xsteps = 1000;

	[signal, M, B] = generate_gradient(@MnUBacmb,@oligomer_BC,p);
	x = linspace(0,p.L,p.xsteps);
	eta = calculate_eta(signal,p)
	figure();
	plot(x,M(1,:))
	plot_title{1} = [ 'Morphogen gradient' ];
	plot_title{2} = ['with $n$=' num2str(p.n) ', $K_1$=' num2str(p.K1) ', $K_2$=' num2str(p.K2) ', $K_3$=' num2str(p.K3) ', $K_6$=' num2str(p.K6) ', $q$=', num2str(p.q)];
	title(plot_title, 'Interpreter','latex','FontSize',20);
	figure();
	plot(x,B(1,:))
	plot_title{1} = [ 'Receptor gradient' ];
	title(plot_title, 'Interpreter','latex','FontSize',20);
	%figure();
	%plot(x,M(1,:))

end