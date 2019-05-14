% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 15]
%
% Evaluate the truncated Taylor series for sin(x) about the point x0 = 0 by
% using Horner?s method.
%
% INPUT
% x .... Vector of values to evaluate the Taylor series at
% n .... Integer of last term to evaluate in Taylor series
%
% OUTPUT
% T : Evaluated Taylor series at points given by x to n terms
% =========================================================================
function H = sinHorner(x, n)
%initialize the H as (-1)^n
H = (-1)^n;
% Loop over terms in series
for k = n:-1:1
    H=(-1)^(k-1)+x.^2 .* H / (2*k*(2*k+1));
end
H=H.*x;
end
