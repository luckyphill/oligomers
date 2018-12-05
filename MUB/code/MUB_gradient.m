function varargout = MUB_gradient(K1,K2,K3)
	
	p.n=1;
	p.n_numerical = p.n;
	p.K1=K1;
	p.K2=K2;
	p.K3=K3;
	p.signal = 'monomer';

	p.L = 1;
	p.xsteps = 1000;

	[signal, M, B] = generate_gradient(@MUB,@oligomer_BC,p);
	x = linspace(0,p.L,p.xsteps);
	eta = calculate_eta(signal,p);

	varargout = {eta, signal, M, B};

	figure();
	plot(x,M)
	plot_title{1} = [ 'Morphogen gradient' ];
	plot_title{2} = ['with $K_1$=' num2str(p.K1) ', $K_2$=' num2str(p.K2) ', $K_3$=' num2str(p.K3)];
	full_title = sprintf('\\begin{tabular}{c} %s \\\\ %s\\end{tabular}',plot_title{1},plot_title{2});
	title(full_title, 'Interpreter','latex','FontSize',20);
	set(gcf, 'Position', [183   630   560   420])
	figure();
	plot(x,B)
	plot_title{1} = [ 'Receptor gradient' ];
	full_title = sprintf('\\begin{tabular}{c} %s \\\\ %s\\end{tabular}',plot_title{1},plot_title{2});
	title(full_title, 'Interpreter','latex','FontSize',20);
	set(gcf, 'Position', [748   630   560   420])
	
	%figure();
	%plot(x,M(1,:))

end