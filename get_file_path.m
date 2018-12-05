function [file_path, directory] = get_file_path(ODE, BC, res, p, r)

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

	% Path will be of the form
	% ODEfn/data/'signal'/'n'/'q'or 'proportion'
	% The path to where the data is saved
	directory = [func2str(ODE), '/data/'];
	if ~strcmp(func2str(ODE), 'MUB')
		directory = [directory p.signal '/n' num2str(p.n) '/'];
		if isfield(p,'q')
			directory = [directory 'q' num2str(p.q) '/'];
		end
		if isfield(p,'proportion')
			directory = [directory  p.proportion '/'];
		end
	end

	if ~exist(directory,'dir')
		mkdir(directory);
	end

	file_path = [directory filename]

end