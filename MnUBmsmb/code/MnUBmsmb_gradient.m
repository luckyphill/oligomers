function MnUBmsmb_gradient(n,K1,K2,K3,K6)
	
	p.n=n;
	p.n_numerical = 1;
	p.K1=K1;
	p.K2=K2;
	p.K3=K3;
	p.K6=K6;
	p.signal = 'monomer';
	p.C = MnUBmsmb_make_coeff(n,K6);
	p.C_max = max(abs(p.C(:,1)));
	N = 1:1:n;
	p.lambda = sqrt(2 * K6 * N.^(1/3));

	p.L = 1;
	p.xsteps = 1000;

	[signal, M, B] = generate_gradient(@MnUBmsmb,@MnUBmsmb_BC,p);
	x = linspace(0,p.L,p.xsteps);
	eta = calculate_eta(signal,p)
	figure();
	plot(x,M(1,:))
	plot_title{1} = [ 'Morphogen gradient' ];
	plot_title{2} = ['with $n$=' num2str(p.n) ', $K_1$=' num2str(p.K1) ', $K_2$=' num2str(p.K2) ', $K_3$=' num2str(p.K3) ', $K_6$=' num2str(p.K6) ];
	full_title = sprintf('\\begin{tabular}{c} %s \\\\ %s\\end{tabular}',plot_title{1},plot_title{2});
	title(full_title, 'Interpreter','latex','FontSize',20);
	set(gcf, 'Position', [183   630   560   420])
	figure();
	plot(x,B(1,:))
	plot_title{1} = [ 'Receptor gradient' ];
	full_title = sprintf('\\begin{tabular}{c} %s \\\\ %s\\end{tabular}',plot_title{1},plot_title{2});
	title(full_title, 'Interpreter','latex','FontSize',20);
	set(gcf, 'Position', [748   630   560   420])
	%figure();
	%plot(x,M(1,:))

end