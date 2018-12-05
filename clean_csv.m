% Transfers all of the incomplete etagrids from csv to mat
% Then produces the image

funcs = {'MnUBac', 'MnUBms', 'MnUBpc', 'MnUBub'};
bind = ['mb', 'ob'];
signal = {'single', 'multiple'};
Num = [5,10,15,20,30,40];
Q = [2, 6, 12, 16, 25, 35]; % this is dependent on n
prop = {'unit', 'weight'};
K3 = {'0_01','0_1','1','10','100'}; % these are exponents
K6 = {'0_0001' '0_001', '0_01','0_1','1','10','100', '1000', '10000'}; %these are exponents

% This loops monomer binding
for i = 1:length(funcs)
	for j = 1:length(Num)
		for k = 1:length(K3)
			for l = 1:length(K6)

				if strcmp(funcs{i},'MnUBac')
					for q = 1:length(Q)
						file_path = [funcs{i} 'mb/data/monomer/n' num2str(Num(j)) '/' 'q' num2str(Q(q)) '/'];
						file_name = ['eta_' funcs{i} 'mb_monomer_n_' num2str(Num(j)) '_K3_' K3{k} '_K6_' K6{l} '_' 'q_' num2str(Q(q)) '_res_100_-8_8_-8_8'];
						[file_path file_name]
						% csv2mat([file_path file_name])
					end
				elseif strcmp(funcs{i},'MnUBpc')
					for p = 1:length(prop)
						file_path = [funcs{i} 'mb/data/monomer/n' num2str(Num(j)) '/' prop{p} '/'];
						file_name = ['eta_' funcs{i} 'mb_monomer_n_' num2str(Num(j)) '_K3_' K3{k} '_K6_' K6{l} '_' 	prop{p} '_res_100_-8_8_-8_8'];
						[file_path file_name]
						% csv2mat([file_path file_name])
					end
				else
					file_path = [funcs{i} 'mb/data/monomer/n' num2str(Num(j)) '/'];
					file_name = ['eta_' funcs{i} 'mb_monomer_n_' num2str(Num(j)) '_K3_' K3{k} '_K6_' K6{l} '_res_100_-8_8_-8_8'];
					[file_path file_name]
					% csv2mat([file_path file_name])		
				end
			end
		end
	end
end

for i = 1:length(funcs)
	for j = 1:length(Num)
		for k = 1:length(K3)
			for l = 1:length(K6)
				for m = 1:length(signal)
					if strcmp(funcs{i},'MnUBac')
						for q = 1:length(Q)
							file_path = [funcs{i} 'ob/data/' signal{m} '/n' num2str(Num(j)) '/' 'q' num2str(Q(q)) '/'];
							file_name = ['eta_' funcs{i} 'ob_' signal{m} '_n_' num2str(Num(j)) '_K3_' K3{k} '_K6_' K6{l} '_' 'q_' num2str(Q(q)) '_res_100_-8_8_-8_8'];
							% [file_path file_name]
							csv2mat([file_path file_name])
						end
					elseif strcmp(funcs{i},'MnUBpc')
						for p = 1:length(prop)
							file_path = [funcs{i} 'ob/data/' signal{m} '/n' num2str(Num(j)) '/' prop{p} '/'];
							file_name = ['eta_' funcs{i} 'ob_' signal{m} '_n_' num2str(Num(j)) '_K3_' K3{k} '_K6_' K6{l} '_' 	prop{p} '_res_100_-8_8_-8_8'];
							% [file_path file_name]
							csv2mat([file_path file_name])
						end
					else
						file_path = [funcs{i} 'ob/data/' signal{m} '/n' num2str(Num(j)) '/'];
						file_name = ['eta_' funcs{i} 'ob_' signal{m} '_n_' num2str(Num(j)) '_K3_' K3{k} '_K6_' K6{l} '_res_100_-8_8_-8_8'];
						% [file_path file_name]
						csv2mat([file_path file_name])		
					end
				end
			end
		end
	end
end

					

