% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 23]
% Task 1
%%
% *lagrange  interpolation formula*
%
% lagrange.m
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
%The following is a code that use lagrange and firstbaryeval function to 
%plot the interpolating polynomial
%
%
%define tau and rho
tau=[-1, -1/2, 1/2, 1];
rho=[-0.7616, -0.4621, 0.4621, 0.7616];
%create 100 equal point between -1 and 1
x=linspace(-1,1,100);
%use lagrange interpolation formula to evalue x
y=lagrange(tau,rho,x);
%use the first form of the barycentric formula to evalue x
z=firstbaryeval(tau,rho,x);
%plot the x y z
plot(x,y,'m',x,z,'--b')
%keep in the same graph
hold on
%plot tau rho
plot(tau,rho,'or')
xlabel('x')
ylabel('y')
title('plot the interpolating polynomial by lagrange and firstbaryeval function')
legend('lagrange','firstbaryeval','interpolation point')