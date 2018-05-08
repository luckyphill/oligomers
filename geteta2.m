function eta=geteta2(BRcurve,p)
	%calculates the eta by percentage of domain that is flat
	comp=max(BRcurve)/p.L;

	gradient_cutoff = 0.6 * comp/p.xsteps;
	%gradient_cutoff = 0.0006 * comp;
	%gradient = zeros(p.xsteps-1,1);

	Lflat = 0;

	for i=1:p.xsteps-1
	    %gradient(i) = BRcurve(i) - BRcurve(i+1);
	    if BRcurve(i) - BRcurve(i+1) < gradient_cutoff
	        Lflat = Lflat + 1;
	    end
	end

	eta=(p.xsteps-Lflat)/p.xsteps;

	if abs(min(BRcurve)/max(BRcurve))>.01
	    eta=-1;
	end

end