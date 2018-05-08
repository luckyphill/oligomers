function filename = parameter_space(ODE, BC, res, p, r)
	% ODE and BC are functions containing the system and boundary conditions respectively
	% res is the resolution of the sweep in pixels per side
	% p is a structure with the fixed parameters for the sweep, usually n, K3, K6, q and the signalling method for oligomers (one signal, or all units signal)
	% p should have:
	% - p.K3
	% - p.K6
	% - p.n - maximum oligomer size
	% - p.n_numerical - the number of equations that are solved numerically. important for when some parts are solved analytically
	% - p.signal = 'single' or 'multiple' if oligomers bind and 'mono' if only monomers bind
	% - p.q (for end unit cleavage model)
	% The remaining parameters are set in this function
	% There is also the parameters for the sweep itself
	% r is the ranges for the two parameters to be swept
	% r should have:
	% - r.p1_min
	% - r.p1_max
	% - r.p2_min
	% - r.p2_max
	
	% TODO: abstract this function so any parameter pair can be swept

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
	        	signal_gradient = generate_gradient(ODE,BC,p);
	            etagrid(i,j) = calculate_eta(signal_gradient,p);
	        catch
	            fprintf('Something funny happened for this combination K1=%.3g K2=%.3g K3=%.3g... skipping\n',K1(i),K2(j),p.K3);
	            etagrid(i,j)=-1;
	        end
	        fprintf('Completed %.2f%% - K1=%.3g K2=%.3g\n',100*((i-1)*res+j)/(res*res),K1(i),K2(j));
	    end
	end



	% Generate the filename
	filename = ['eta_', func2str(ODE),'_',p.signal,'_n_',num2str(p.n),'_K3_', num2str(p.K3),'_K6_',num2str(p.K6)];
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

end