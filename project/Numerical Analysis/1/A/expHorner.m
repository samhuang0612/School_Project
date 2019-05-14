% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 15]
%
% Evaluate exp(x) about the point x0 = 0 using Horner's method
%
% INPUT
% x .... Vector of values to evaluate the Taylor polynomial at
% n .... Integer of last term to evaluate in Taylor polynomial
%
% OUTPUT
% H : Evaluated Taylor polynomial at points given by x degree n
% =========================================================================
function H = expHorner(x, n)
% Initialize sum as 0
H = 1;
for k = n:-1:1
    H =  1 + x.* H/k;
end
end