function [signal_gradient, varargout] = generate_gradient(ODE, BC, p)
	% Runs solve oligomer and then deals with the output depending on the system we are solving
    % Can also optionally return all the bound receptor profiles for each oligomer

    % M_full includes the first derivative
	M_full = solve_oligomer(ODE, BC, p);
    % Only need the first n results, the remainder are first derivatives
    M = M_full(1:p.n_numerical,:);
	
    switch p.signal
    case 'monomer'
    	% if only monomer binding
    	M1=M(1,:);
        
        if isfield(p,'C')
             %p.C_max = 1;%max(abs(p.C(:,1)));
             signal_gradient = p.C_max * M1 ./ (p.K2 + p.C_max * M1); % resulting B concentration profile when only monomers can bind
         else
             signal_gradient = M1 ./ (p.K2 + M1); % resulting B concentration profile when only monomers can bind
         end

        varargout{1} = M;
        varargout{2} = signal_gradient; % This is just B
    
    case 'single'
        % if oligomer binding with single signal
        len = length(M(1,:));
        Msum = zeros(1,len);
        Mwsum = zeros(1,len);
        for i=1:p.n
            Msum = Msum + M(i,:);
            Mwsum = Mwsum + i * M(i,:); %oligomers signal for each monomer
        end

        B_olig = M ./ (p.K2 + Msum); % resulting B concentration profiles when oligomers can bind
        signal_gradient = Msum ./ (p.K2 + Msum); % signal profile - oligomers signal once
        
        varargout{1} = M;
        varargout{2} = B_olig;

    case 'multiple'
        % if oligomer binding with multiple signalling
        len = length(M(1,:));
        Msum = zeros(1,len);
        Mwsum = zeros(1,len);
        for i=1:p.n
            Msum = Msum + M(i,:);
            Mwsum = Mwsum + i * M(i,:); %oligomers signal for each monomer
        end

        B_olig = M ./ (p.K2 + Msum); % resulting B concentration profiles when oligomers can bind
        signal_gradient = Mwsum ./ (p.K2 + Msum); % signal profile - oligomers signal multiple times
        
        varargout{1} = M;
        varargout{2} = B_olig;

    otherwise
        fprintf('Invalid signal specifier. Choose one of monomer, single or multiple');

    end
    varargout{3} = M_full;


end