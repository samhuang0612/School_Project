%%
% =========== 
% *Problem 1*
%
% Author : Lishan Huang, Nick Hoffman, Harman Sahni, Nastaran Gh
% Created : January 24th, 2019
% Last Updated : January 31st, 2019
%
% Plot second barycentric interpolation of a switch function on the range
% [-5,5]
%
% ===========

% clear figures, close plot windows, clear variables

clf;
close all;
clear all;

    % Define some data (taken from Lab 2A)
    tau = [-5, -4.698, -3.830, -2.5, -0.8695, 0.8695, 2.5, 3.830, 4.698,...
           5.0];
       
    rho = [0.006693, 0.009032, 0.02125, 0.07607, 0.3080, 0.9368, 1.873,...
           2.8, 3.457, 3.693];

    % Points we want to evaluate the interpolating polynomial at
    x = linspace(-5, 5, 2814);

    % The values of the interpolating polynomial for tau and rho at 
    % each point in x
    
    p = secondbaryeval(tau, rho, x) ;
    
    % Plot the interpolating polynomial on [-5,5]
        plot(x,p)
        hold on
        plot(tau,rho,'o')
        title('Interpolant of switch function and its nodes')
        xlabel('[-5,5]')
        ylabel('Values')
        
    % Plot r(x) = p(x) + ln p(x) ? x on [-5,5]     
        figure(2)
        r=p+log(p)-x;
        plot(x,r)
        title('r(x) on [-5,5]')
        xlabel('[-5,5]')
        ylabel('Values')

    
% END SCRIPT
% ===========