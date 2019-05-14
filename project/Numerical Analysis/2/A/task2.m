% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 23]
% Task 2
%%
% *lagrange  interpolation formula*
%
% slagrange.m
%
% <include>lagrange.m</include>
% 
% *The first form of the barycentric formula*
%
% firstbaryeval.m
%
% <include>firstbaryeval.m</include>
% 
%%
% *Script*
%
%The following is a code that using firstbaryeval function to interpolate 
%the function f(x)=1/(1+x^2) and plot the forward error between f(x) and p(z)
%
%create a vector with 11 equal point between -5 and 5
tau=linspace(-5,5,11);
%
%calculate the value of rho by given function
rho=1./(1+tau.^2);
%create a vector with 100 equal point between -5 and 5
z=linspace(-5,5,100);
%calculate f(x) of vector z by given function and store in k
k=1./(1+z.^2);
%definition of first barycentric  form interpolation
t=firstbaryeval(tau,rho,z);
%plot result of the interpolation poin
plot(z,abs(k-t))
xlabel('x')
ylabel('y')
title('forward error of f(x)-p(x)')
%%

% *Text Answers*
%No, it is not a good interpolant, because when the absolute value of x is away from 0, the error between adjacent interpolation points will increase, then it falses to  predit the values between adjacent interpolation points. In especially, when the absolute value of x is greater than 4, the errors of the interpolant begins to skyrocket thus it also can not predict the output for x that is out of the range of interpolation point