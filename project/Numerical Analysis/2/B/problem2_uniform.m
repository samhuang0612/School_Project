%%
% =========== 
% *Problem 2_unifrom*
%
% Author : Lishan Huang, Nick Hoffman, Harman Sahni, Nastaran Gh
% Created : January 24th, 2019
% Last Updated : January 31st, 2019
%
% Interpolating the gamma function using Equally-spaced nodes
%
% ===========
% clear figures, close plot windows, clear variables

%%
%text
clf
close all
clear all
  % create a vector with 1000 equal points bewteen 1 and 1000
    che=linspace(0,999,1000);
   % use the given fucntion to create 1000 Equally-spaced nodes in [1,2]
    chenode=1+che/999;
   % calculate the exact result for those Equally-spaced nodes in gamma
   % function
    chegamma=gamma(chenode);
   % create a vector that stores the numbers of nodes to be interpolated
   % where n=9 17 and 19 and then number of nodes are 10 18 20
    number=[9 17 19];
   % use for loop repeat steps from 1 to 5 
 for i=1:length(number)
%question 1
        % create tau and rho with number of n=number(i)
        node=linspace(0,number(i),number(i)+1);
        tau=1+node/(number(i))
        name='Equally-spaced';
        figure((i-1)*4+1)
        rho=gamma(tau);
        
       %The values of the interpolating polynomial for tau and rho at each point in x
        p=secondbaryeval(tau,rho,chenode);
       %plot the values of interpolating polynomial
        plot(chenode,p,'r')
        %axis label
        xlabel('x')
        ylabel('y')
        %title
        title([name ' interpolant for n=',num2str(number(i))])
        hold on
        %plot interpolation points in same graph 
        plot(tau,rho,'o')
        figure((i-1)*4+2)
        
%question 2
        %plot the the error in  interpolant
        plot(chenode,abs(chegamma-p))
        xlabel('x');
        ylabel('y');
        title(['Error in ' name ' interpolant for n=' num2str(number(i))])
        
%question 3
        % create the Vandermonde matrix  for tau
        V=vander(tau);
        % transform rho from row vector to column vector
        rhoR=rho.';
        %solve Va = ? to get the coefficient vector
        a = V\rhoR;
        %evaluate interpolating polynomial expressed in the monomial basis
        y=polyval(a,chenode);
        figure((i-1)*4+3)
        %plot interpolating polynomial expressed in the monomial basis
        plot(chenode,y)
        xlabel('x');
        ylabel('y');
        title({[name ' interpolant  '];['expressed in the monomial basis for n=' num2str(number(i))]})
        hold on
        %plot interpolation points in same graph 
        plot(tau,rho,'o')
        
%question 4
         %plot the the error in  interpolant expressed in the monomial basis
        figure((i-1)*4+4)
        plot(chenode,abs(chegamma-y))
        xlabel('x');
        ylabel('y');
        title({['Error in ' name ' interpolant  '];['expressed in the monomial basis for n=' num2str(number(i))]})
           if i==3  
                    %gamma 5/2
                    disp('rho(5/2) by  secondbaryeval interpolant directly') 
                        secondbaryeval(tau,rho,5/2) 
                    disp('rho(5/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        3/2*secondbaryeval(tau,rho,3/2) 
                    disp('gamma(5/2)') ;
                        gamma(5/2) 
                    disp('error for rho(5/2) by  secondbaryeval interpolant directly') 
                        abs(gamma(5/2)-secondbaryeval(tau,rho,5/2))
                    disp('error for rho(5/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        abs(gamma(5/2)- 3/2*secondbaryeval(tau,rho,3/2)) 
                    %gamma 7/2 
                    disp('rho(7/2) by  secondbaryeval interpolant directly') 
                        secondbaryeval(tau,rho,7/2) 
                    disp('rho(7/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        (5/2)*(3/2)*secondbaryeval(tau,rho,3/2)   
                    disp('gamma(7/2)') ;
                        gamma(7/2) 
                    disp('error for rho(7/2) by  secondbaryeval interpolant directly') 
                        abs(gamma(7/2)-secondbaryeval(tau,rho,7/2))
                    disp('error for rho(7/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        abs(gamma(7/2)- (5/2)*(3/2)*secondbaryeval(tau,rho,3/2))
                    %gamma 9/2
                    disp('rho(9/2) by  secondbaryeval interpolant directly') 
                        secondbaryeval(tau,rho,9/2)
                    disp('rho(9/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        7/2*5/2*3/2*secondbaryeval(tau,rho,3/2) 
                    disp('gamma(9/2)') ;
                        gamma(9/2) 
                    disp('error for rho(9/2) by  secondbaryeval interpolant directly') 
                        abs(gamma(9/2)-secondbaryeval(tau,rho,9/2))
                    disp('error for rho(9/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        abs(gamma(9/2)- (7/2)*(5/2)*(3/2)*secondbaryeval(tau,rho,3/2))
            end
 end
  
    