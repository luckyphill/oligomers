function varargout = MnUBacobas_gradient(n,K1,K2,K3,K6,q)
	
	p.n=n;
	p.n_numerical = n;
	p.K1=K1;
	p.K2=K2;
	p.K3=K3;
	p.K6=K6;
	p.q = q;
	p.signal = 'multiple';

	p.L = 1;
	p.xsteps = 1000;

	[signal, M, B] = generate_gradient(@MnUBacob,@oligomer_BC,p);
	x = linspace(0,p.L,p.xsteps);
	eta = calculate_eta(signal,p);

	varargout = {eta, signal, M, B};

	figure();
	plot(x,M(1,:))
	plot_title{1} = [ 'Morphogen gradient' ];
	plot_title{2} = ['with $n$=' num2str(p.n) ', $K_1$=' num2str(p.K1) ', $K_2$=' num2str(p.K2) ', $K_3$=' num2str(p.K3) ', $K_6$=' num2str(p.K6) ', $q$=' num2str(p.q) ];
	full_title = sprintf('\\begin{tabular}{c} %s \\\\ %s\\end{tabular}',plot_title{1},plot_title{2});
	title(full_title, 'Interpreter','latex','FontSize',20);
	set(gcf, 'Position', [183   630   560   420])
	figure();
	plot(x,signal(1,:))
	plot_title{1} = [ 'Signal gradient' ];
	full_title = sprintf('\\begin{tabular}{c} %s \\\\ %s\\end{tabular}',plot_title{1},plot_title{2});
	title(full_title, 'Interpreter','latex','FontSize',20);
	set(gcf, 'Position', [748   630   560   420])
	
	%figure();
	%plot(x,M(1,:))

end