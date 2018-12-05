model = 'MnUBpcmb';
signalling = 'monomer';
prop = 'unit'; % = 'weight';

K6 = [10000,1000,100,10,1,0.1,0.01,0.001,0.0001];

K3 = 10;

n = 10;

res = 100;
h = figure();

for i = 1:length(K6)
    file_name = ['eta_' model '_' signalling '_n_' num2str(n) '_K3_' num2str(K3) '_K6_' num2str(K6(i)) '_' prop '_res_100_-8_8_-8_8'];
    for k = 1:length(file_name - 4)
        if file_name(k) == '.'
            file_name(k) = '_';
        end
    end

    path = [model '/' file_name '.mat'];
    try
        load(path)
        subplot(3,3,i);
        imagesc(rot90(etagrid),[0 1])
        colormap jet
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        set(gca,'ytick',[])
        set(gca,'yticklabel',[])
        xlabel(['$K_6$=' num2str(K6(i))],'Interpreter','latex')
    catch
        fprintf('No file found\n');
    end
    
        
end

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
output_file = ['tiled_plot_' model '_' signalling '_n_' num2str(n) '_K3_' num2str(K3)];
for k = 1:length(output_file)
    if output_file(k) == '.'
        output_file(k) = '_';
    end
end
plot_title{1} = [model, ' ', signalling, ' signalling, proportional to ' prop];
plot_title{2} = ['Varying $K_6$ with $n$=' num2str(n) ', $K_3$=' num2str(K3)];

a = axes;
t1 = title(plot_title, 'Interpreter','latex','FontSize',14);
a.Visible = 'off'; % set(a,'Visible','off');
t1.Visible = 'on'; % set(t1,'Visible','on');

print(output_file,'-dpdf')
