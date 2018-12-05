function csv2mat(file_path)
	% Must provide file path without the file extension
	try % This will fail when the csv doesn't exist, so put it in a try statement 
		% It would be better to do this in an if statement because it won't trigger an error

		temp = csvread([file_path '.csv']);

		load([file_path, '_temp.mat'])
		eta_grid = nan(res);

		eta_grid(1:length(temp)) = temp(:,3);

		etagrid = rot90(flipud(eta_grid),3); % Need to rotate and flip so it is the same as the normally produced etagrids

		save(file_path,'etagrid','p','r','res','ODE','BC','K1','K2');

		plot_parameter_space(file_path)
	catch
		disp(file_path)
	end

end

% imagesc(etagrid,'AlphaData',~isnan(etagrid))
% colormap jet