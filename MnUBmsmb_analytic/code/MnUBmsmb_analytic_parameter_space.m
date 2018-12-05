	function MnUBmsmb_analytic_parameter_space(n,K3,K6)

	ODE = @MnUBmsmb_analytic;
	BC = @No_BC;
	p.n=n;
	p.K3=K3;
	p.K6=K6;
	p.signal = 'monomer';
	N = 1:1:n;

	r.p1_min = -8;
	r.p1_max = 8;
	r.p2_min = -8;
	r.p2_max = 8;

	res = 100;

	K1=logspace(r.p1_min,r.p1_max,res);
    K2=logspace(r.p2_min,r.p2_max,res);

	% These will rarely be changed, so fix them here
	p.L = 1;
	p.xsteps = 1000;
	
	etagrid = zeros(res);
	for i=1:res
	    for j=1:res
	        try 
	        	% Need to change the values of p.K1 and p.K2 here
	        	p.K1 = K1(i);
	        	p.K2 = K2(j);
	        	[signal_gradient,M] = MnUBmsmb_limit_K2(p.n,p.K1,p.K2,p.K3,p.K6);
	        	if M(1) < .01 * p.K2
	        		fprintf('Using approximation since M(1) = %.3g and K2 = %.3g\n', M(1), p.K2);
	        		etagrid(i,j) = calculate_eta(signal_gradient,p);
	            end
	            if M(1) < 0
	            	fprintf('Somethings wrong, M is -ve\n')
	            	etagrid(i,j) = 0;
	            end
	            %etagrid(i,j) = calculate_eta(signal_gradient,p);
	            %fprintf('Using approximation M(1) = %.3g K2 = %.3g\n', M(1), p.K2);
	        catch
	            fprintf('Something funny happened for this combination K1=%.3g K2=%.3g K3=%.3g... skipping\n',K1(i),K2(j),p.K3);
	            etagrid(i,j)=-1;
	        end
	        fprintf('Completed %.2f%% - K1=%.3g K2=%.3g\n',100*((i-1)*res+j)/(res*res),K1(i),K2(j));
	    end
	end



	% Generate the filename
	filename = ['eta_', func2str(ODE),'_',p.signal,'_n_',num2str(p.n),'_K3_', num2str(p.K3)];
	if isfield(p,'K6')
		filename = [filename, '_K6_', num2str(p.K6)];
	end
	if isfield(p,'proportion')
		filename = [filename, '_', num2str(p.proportion)];
	end
	if isfield(p,'q')
		filename = [filename, '_q_', num2str(p.q)];
	end
	filename = [filename, '_res_',num2str(res),'_',num2str(r.p1_min), '_',num2str(r.p1_max), '_',num2str(r.p2_min), '_',num2str(r.p2_max)];
	for m=1:length(filename)
	    if filename(m)=='.'
	        filename(m)='_';
	    end
	end

	if ~exist(func2str(ODE),'dir')
		mkdir(func2str(ODE));
	end

	filename = [func2str(ODE), '/', filename];
	% Save all the data
	save(filename,'etagrid','p','r','res','ODE','BC','K1','K2');

	plot_parameter_space(filename)

end