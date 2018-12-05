function tile_plot_K6(front_part, back_part)

    K6 = [10000,1000,100,10,1,0.1,0.01,0.001,0.0001];

    h = figure();

    for i = 1:length(K6)
        file_path = [front_part num2str(K6(i)) back_part];
        for k = 1:length(file_path)
            if file_path(k) == '.'
                file_path(k) = '_';
            end
        end

        try
            load(file_path)
            subplot(3,3,i);
            imagesc(rot90(etagrid),'AlphaData',~isnan(rot90(etagrid)),[0,1])
            colormap jet
            set(gca,'xtick',[])
            set(gca,'xticklabel',[])
            set(gca,'ytick',[])
            set(gca,'yticklabel',[])
            xlabel(['$K_6$=' num2str(K6(i))],'Interpreter','latex')
        catch
            fprintf('No file found\n');
            disp(file_path);
            % close(h);
        end
        
            
    end

    try
        set(h,'Units','Inches');
        pos = get(h,'Position');
        set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
        output_file = [func2str(ODE) '/tiled_plot_' func2str(ODE) '_' p.signal '_n_' num2str(p.n) '_K3_' num2str(p.K3)];
        if isfield(p,'proportion')
            output_file = [ output_file '_' p.proportion];
        end
        if isfield(p,'q')
            output_file = [ output_file '_q_' num2str(p.q)];
        end
        for k = 1:length(output_file)
            if output_file(k) == '.'
                output_file(k) = '_';
            end
        end
        plot_title{1} = [func2str(ODE), ' ', p.signal, ' signalling'];
        if isfield(p,'proportion')
            plot_title{1} = [ plot_title{1} ' prop to ' p.proportion];
        end
        if isfield(p,'q')
            plot_title{1} = [ plot_title{1} ' $q=$ ' num2str(p.q)];
        end
        plot_title{2} = ['Varying $K_6$ with $n$=' num2str(p.n) ', $K_3$=' num2str(p.K3)];

        a = axes;
        t1 = title(plot_title, 'Interpreter','latex','FontSize',14);
        a.Visible = 'off'; % set(a,'Visible','off');
        t1.Visible = 'on'; % set(t1,'Visible','on');

        print(output_file,'-dpdf')

        close(h);
    end

end
