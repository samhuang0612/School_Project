% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 23]
%
% Evaluate the Lagrange interpolation formula
%
% INPUT
% tau .... The vector of interpolation nodes (length n)
% rho .... The vector of values at the interpolation nodes (length n)
% x   .... A vector of values to evaluate the interpolating polynomial at (length 1 to many (probably not n!))
%
% OUTPUT
% T :  
% =========================================================================
function F = lagrange(tau, rho, x)
%initialize F=0
t=tau;
p=rho;
F=0;
%create a for loop 
    for k=1:length(t)
        %make L=1 before each loop where l means Lk in the function
        L=1;
        for i=1:length(t)
            if i~=k
                L=L.*(x-t(i))./(t(k)-t(i));
            end
        end
        F=F+p(k).*L;
    end
end

    
    