function file_path = parameter_space(ODE, BC, res, p, r)
	% ODE and BC are functions containing the system and boundary conditions respectively
	% res is the resolution of the sweep in pixels per side
	% p is a structure with the fixed parameters for the sweep, usually n, K3, K6, q and the signalling method for oligomers (one signal, or all units signal)
	% p should have:
	% - p.K3
	% - p.K6
	% - p.n - maximum oligomer size
	% - p.n_numerical - the number of equations that are solved numerically. important for when some parts are solved analytically
	% - p.signal = 'single' or 'multiple' if oligomers bind and 'monomer' if only monomers bind
	% - p.q - for end unit breakage model, 1<q<p.n
	% - p.proportion - for proportional breakage model, 'unit' if proportional to number of oligomer, 'weight' if proportional to weight of oligomer
	% The remaining parameters are set in this function
	% There are also the range parameters for the sweep itself
	% r is the ranges for the two parameters to be swept
	% r should have:
	% - r.p1_min
	% - r.p1_max
	% - r.p2_min
	% - r.p2_max
	
	% TODO: abstract this function so any parameter pair can be swept

	% Set the parameter space
	K1 = logspace(r.p1_min,r.p1_max,res);
    K2 = logspace(r.p2_min,r.p2_max,res);

	% These will rarely be changed, so fix them here
	p.L = 1;
	p.xsteps = 1000;
	
	etagrid = nan(res);


	[file_path, directory] = get_file_path(ODE, BC, res, p, r);

	% Saves the parameters in a temp file in case sweep doesn't complete
	temp_params = [file_path '_temp'];
	save(temp_params,'p','r','res','ODE','BC','K1','K2');
	
	% This file is for storing the progress
	% As it appends, we need to delete it first
	csv_file = [file_path, '.csv'];
	if exist(csv_file,'file')
		delete(csv_file);
	end

	for i=1:res
	    for j=1:res
            tic;
	        try 
	        	% Need to change the values of p.K1 and p.K2 here
	        	p.K1 = K1(i);
	        	p.K2 = K2(j);

	        	% This line solves the ODE and receives the signal gradient profile
	        	signal_gradient = generate_gradient(ODE,BC,p);

	        	% This line calculates the quality of the signal gradient profile
	        	% Note that only the qualitynis stored, the profile is discarded
	            etagrid(i,j) = calculate_eta(signal_gradient,p);

            catch e
            	% Catches errors and prints them to output
            	% Errors are usually singular Jacobians, when the system cannot be solved
            	e
	            fprintf('Something funny happened for this combination K1=%.3g K2=%.3g K3=%.3g... skipping\n',K1(i),K2(j),p.K3);
	            %etagrid(i,j)=-1;
	        end

	        fprintf('Completed %.2f%% taking %.4fs - K1=%.3g K2=%.3g\n',100*((i-1)*res+j)/(res*res),toc,K1(i),K2(j));
	        % Write to file to store incomplete parameter sweeps
	        dlmwrite(csv_file, [K1(i),K2(j),etagrid(i,j)], '-append');

	    end
	end


	% Save all the data
	save(file_path,'etagrid','p','r','res','ODE','BC','K1','K2');

	% If the sweep completes successfully, we don't need the csv file or the temp parameter storage
	delete(csv_file);
	delete([temp_params '.mat']);

end