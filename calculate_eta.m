function eta = calculate_eta(signal, p)
	% calculates the eta by percentage of domain that is flat
	a = 0.6;
	comp=max(signal)/p.L;

	gradient_cutoff = a * comp/p.xsteps; % a is a tuning parameter used to make this method match Landers method

	Lflat = 0;

	for i=1:p.xsteps-1
	    if signal(i) - signal(i+1) < gradient_cutoff
	    	% If the approximate gradient is not large enough
	        Lflat = Lflat + 1;
	    end
	end

	eta = (p.xsteps-Lflat)/p.xsteps;

	if abs(min(signal)/max(signal))>.01
	    eta = -1;
	end

end