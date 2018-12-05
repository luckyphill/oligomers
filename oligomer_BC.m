function res = oligomer_BC(Ma,Mb,p)
	% Basic BC function that should meet the needs of most oligomer systems
	% p is a structure of parameters
    res = zeros(2*p.n,1);
    for k=1:p.n-1
       res(k) = Ma(p.n+k);
       res(p.n+k)= Mb(k);
    end
    res(p.n) = Ma(2*p.n)+p.K3/p.n^(2/3);
    res(2*p.n) = Mb(p.n);
end