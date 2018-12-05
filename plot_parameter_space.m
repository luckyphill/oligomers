function plot_parameter_space(file_path)
	% Works with or without file extension
	% Only works with the new data structure

	load(file_path);

	for i=1:res
	    for j=1:res
	            if etagrid(i,j)==3
	                etagrid(i,j)=0;
	            end
	            if etagrid(i,j)==10
	                etagrid(i,j)=0;
	            end
	            if etagrid(i,j)==-1
	                etagrid(i,j)=0;
	            end
	    end
	end

	%create tick labels in a cell
	numticks=9;
	for i=1:numticks
	    ticklabel_x{i} = num2str(r.p1_max-((i-1)*(r.p1_max-r.p1_min)/(numticks-1)));
	    ticklabel_y{i} = num2str(r.p2_max-((i-1)*(r.p2_max-r.p2_min)/(numticks-1)));
	end

	% Plot the figure and set axis labels etc.
	h = figure();
	set(gcf,'Visible', 'off'); 
	imagesc(rot90(etagrid),'AlphaData',~isnan(rot90(etagrid)), [0,1])
	colormap jet
	set(gca, 'XTick', linspace(.5, res + .5, numticks))
	set(gca, 'XTickLabel', fliplr(ticklabel_x))
	set(gca, 'YTick', linspace(.5, res + .5, numticks))
	set(gca, 'YTickLabel', ticklabel_y)
	xlabel('$\log_{10}(K_1)$','Interpreter','latex','FontSize',20)
	ylabel('$\log_{10}(K_2)$','Interpreter','latex','FontSize',20)
	colorbar;


	% Make the plot title
	plot_name = func2str(ODE);
	plot_title{1} = [plot_name, ' ', p.signal, ' signalling'];

	if p.n == 1
		plot_title{1} = ['MUB $\eta$ with $K_3$=' num2str(p.K3)];
	else
		plot_title{2} = ['$\eta$ with $n$=' num2str(p.n) ', $K_3$=' num2str(p.K3) ', $K_6$=' num2str(p.K6)];
		if isfield(p,'q')
			plot_title{2} = [plot_title{2}, ', $q$=', num2str(p.q)];
		end
	end

	title(plot_title, 'Interpreter','latex','FontSize',20);
	
	% Save the plot to pdf
	set(h,'Units','Inches');
	pos = get(h,'Position');
	set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

	print(file_path,'-dpdf')

	close(h);

end