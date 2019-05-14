% =========================================================================
% AUTHOR ..... Huang, Lishan  Han, Jiarong Brown, Fraser Chen, Yushan 
% DATE .... March 22
%
% Description:  W. Kahan's work on method to solve intergration rounding
% error
% =========================================================================
%%
% *Script*
    clear all
    close all  
    format long
    A = @(x) x.^-1 * integral(@(u) (u.^-2) .* sqrt(-2*log(cos(u.^2))),0,x)
    % display the value of A(0.1) 
    disp(A(0.01))
    %since it is less than 1 which is not satisfy the Taylor series so it
    %must be incorrect
    
    % test for work on method
    
    sprintf('workOn method when x =1 is %d', workOn(1))
    sprintf('workOn method when x =0.1 is %d', workOn(0.1))
    sprintf('workOn method when x =0.01 is %d', workOn(0.01))
    sprintf('workOn method when x =0.001 is %d', workOn(0.001))
    sprintf('workOn method when x =0.0001 is %d', workOn(0.0001))

% Used the Composite Trapezoidal Rule to adjust the work on method
function sum = workOn(x)
%define function
    y = @(u) cos(u^2);
    f = @(y) sqrt(-2*log(y))/acos(y);
    
    %define output and total step 
    sum=0;
    n=1000000;
    
    %the left and right of integration
    a=0;
    b=x;

    %if the right side of integration is equal to left side then return 1
    if b~=0
        
      % work on method, if y=1 then the function =1 otherwise keep
      % origional method   
        f1=1;
            if y(a)~=1
                f1=f(y(a));
            end 
            
        f2=1;
            if y(b)~=1
                f2=f(y(b));
            end
            
        %step size and sigma in  the Composite Trapezoidal Rule 
        h=(b-a)/n;
        sigma=0;
        
        %loop for the total step
            for k=1:n-1
                %suppose y=1 at first and store in target
                target=1;
                %if it is not 1 then used f and store in target
                if y(a+h*k)~=1
                    target=f(y(a+h*k));
                end
            %sum the target 
                sigma=target+sigma;
                
            end
            
            %definition of the Composite Trapezoidal Rule and divide by b
            %to get the given A
        sum=h*(0.5*f1 + 0.5*f2 + sigma)/b;
        
    else
        %if left side equal right side the return 0
        sum=1;    
    end
    
end

