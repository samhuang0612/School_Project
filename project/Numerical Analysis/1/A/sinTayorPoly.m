% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 15]
%
% Evaluate the truncated Taylor series for sin(x) about the point x0 = 0
%
% INPUT
% x .... Vector of values to evaluate the Taylor series at
% n .... Integer of last term to evaluate in Taylor series
%
% OUTPUT
% T : Evaluated Taylor series at points given by x to n terms
% =========================================================================
function T = sinTayorPoly(x, n)
% Initialize sum as 0
T = 0;
% Loop over terms in series
for k = 0:n
    T = T +(-1)^k * x.^(2*k+1)/factorial(2*k+1);
end
end
