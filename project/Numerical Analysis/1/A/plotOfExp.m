% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 15]
%
%%
% *expTaylorPoly function*
%
% expTaylorPoly.m
%
% <include>expTaylorPoly.m</include>
%%
% *expHorner function*
%
% expHorner.m
%
% <include>expHorner.m</include>
%%
% *Script*
%
%The following is a code that Plotted the approximates of exp(x) on the 
%Horner method and use exp function directly
clf;
close all;
clear all;
%50 equally-spaced x values between -4 and 4
x = linspace(-4,4,50);
%Evaluate exp(x)
e=exp(x);
%Evaluate the exp(x) Taylor Polynomial on the Horner method in at n = 2
H2 = expHorner(x,2);
%Evaluate the exp(x) Taylor Polynomial on the Horner method at n = 3
H3 = expHorner(x,3);
%Evaluate the exp(x) Taylor Polynomial on the Horner method at n = 5
H5 = expHorner(x,5);
% Plotting the approximates of exp(x)
plot(x,e,'--g',x,H2,'*r',x,H3,'.b',x,H5,'+k')
% add the legend to the graph
legend('exp','H2', 'H3', 'H5')
% add the label of the graph
title("'Approximation of exp(x) using Taylor Polynomials on the Horner method")
xlabel('x')
ylabel('y')
