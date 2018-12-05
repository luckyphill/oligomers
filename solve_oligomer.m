function M = solve_oligomer(ODE, BC, p)
    % This function expects to recieve a function containing the ODE system to be solved
    % and a function containing the boundary conditions as the first two arguments
    % p is a structure containing all the parameters that the ODE and BC functions need
    % It returns a matrix containing the spatial concentrations for each oligomer
    
    if isfield(p,'guess')
        % If we are provided with an initial guess, use that
        % The guess will be a nearby solution
        % Have to create the solinit manually since it doesn't like matrix guesses
        %solinit = bvpinit(linspace(0, p.L, p.xsteps), p.guess);
        solinit.x = linspace(0, p.L, 10);
        solinit.y = p.guess(:,(p.xsteps/10):(p.xsteps/10):p.xsteps);
    else
        solinit = bvpinit(linspace(0,p.L,10),zeros(1,2*p.n_numerical));
    end

    options = bvpset('NMax',10000, 'RelTol', 1e-10, 'AbsTol', 1e-10);

    sol = bvp5c( @(x,M)ODE(x,M,p), @(Ma,Mb)BC(Ma,Mb,p), solinit, options);
    
    xint = linspace(0, p.L, p.xsteps);
    [M, ~] = deval(sol, xint);

end