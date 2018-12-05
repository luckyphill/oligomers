function MnUBmsmb_limit_K2_gradient(n,K1,K2,K3,K6)
	
	[B,M] = MnUBmsmb_limit_K2(n,K1,K2,K3,K6);

	figure();
	plot(B)
	plot_title{1} = [ 'Receptor gradient' ];
	plot_title{2} = ['with $n$=' num2str(n) ', $K_1$=' num2str(K1) ', $K_2$=' num2str(K2) ', $K_3$=' num2str(K3) ', $K_6$=' num2str(K6) ];
	full_title = sprintf('\\begin{tabular}{c} %s \\\\ %s\\end{tabular}',plot_title{1},plot_title{2});
	title(full_title, 'Interpreter','latex','FontSize',20);
	set(gcf, 'Position', [748   630   560   420])


end
