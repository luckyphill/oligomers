function M = solve_oligomer(ODE, BC, p)
    % This function expects to recieve a function containing the ODE system to be solved
    % and a function containing the boundary conditions as the first two arguments
    % p is a structure containing all the parameters that the ODE and BC functions need
    % It returns matrix containing the morphogen concentrations
    
    solinit = bvpinit(linspace(0,p.L,10),zeros(1,2*p.n_numerical));
    options = bvpset('NMax',1000);

    sol = bvp5c( @(x,M)ODE(x,M,p), @(Ma,Mb)BC(Ma,Mb,p), solinit, options);
    
    xint = linspace(0, p.L, p.xsteps);
    [M, ~] = deval(sol, xint);
    
    % Only need the first n results, the remainder are first derivatives
    M = M(1:p.n_numerical,:);

end