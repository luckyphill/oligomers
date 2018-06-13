% A script to use on phoenix HPC to solve all the systems with n=10
% The resolution of the plot is set at 40 in the scripts, so these will run at max 30 mins each


funcs = {@MnUBacmb_sweep, @MnUBacob_sweep, @MnUBacobas_sweep, @MnUBmsmb_sweep, @MnUBmsob_sweep, @MnUBmsobas_sweep, @MnUBpcmb_sweep, @MnUBpcob_sweep, @MnUBpcobas_sweep, @MnUBubmb_sweep, @MnUBubob_sweep, @MnUBubobas_sweep};

K3 = 1;
n = 10;
q = [2,5,8];
K6 = [0.0001, .001, .01, .1, 1, 10, 100, 1000, 10000];

for i = 4:1:12
	for j = 1:1:9
		funcs{i}(n,K3,K6(j));
	end
end