% =========================================================================
% AUTHOR ..... Lishan Huang
% DATE .... March 18
%
% Function of the corrected trapezoidal rule
%
% INPUT
%
% A function handle for the function to be integrated
% Left endpoint of the interval to be integrated
% Right endpoint of the interval to be integrated
% The number of subdivisions to divide the interval into
% The values of f'(a) and f'(b) (if zero, just ordinary trapezoidal rule)
%
% OUTPUT
% The value of the integral of the input function between the endpoint
%
% =========================================================================
%%
%* Script*
function m = corrTrap(f,LeftEnd,RightEnd,Num,dfa,dfb)
%store the input value
a=LeftEnd;
b=RightEnd;
n=Num;
h=(b-a)/n;
sigma=0;
%calculate sigmaf(xk) be definition
    for k=1:n-1
        sigma=sigma+f(a+k*h);
    end
    %formular of definition
m=h*(0.5*f(a)+sigma+0.5*f(b))+h^2*(dfa-dfb)/12;
end