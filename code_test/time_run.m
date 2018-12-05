
x = 1;
p.K1 = 1e4;
p.K2 = 1e4;
p.K6 = 10;

runs = 1000;

for j=2:40
	p.n = j;
	if j > 2
		p.q = floor(j/2);
	else
		p.q = 1;
	end
	M = [1:j,101:(100+j)]';
	tic;
	for i=1:runs
		MnUBacmb(x,M,p);
	end
	test1(j) = toc;
	tic;
	for i=1:runs
		MnUBacmb2(x,M,p);
	end
	test2(j) = toc;
end

% test1
% test2
test1./test2


