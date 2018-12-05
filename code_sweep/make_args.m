file = fopen('args_q.csv','w');

n = [5,10,15,20,30,40];
K3 = [-2,-1,0,1,2]; % these are exponents
K6 = [-4,-3,-2,-1,0,1,2,3,4]; %these are exponents
q = [2, 6, 12, 16, 25, 35]; % this is dependent on n

for i = 1:length(n)
	for j = 1:length(K3)
		for k = 1:length(K6)
			for l = 1:length(q)
				if q(l) < n(i)
					fprintf(file, '%d,%d,%d,%d\n',n(i),K3(j),K6(k),q(l));
				end
			end
		end
	end
end

fclose(file);