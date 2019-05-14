% =========================================================================
% AUTHOR ..... [Huang Lishan, Yang, Wenshuo, Hoffman, Nicholas, Tamkee, Michael]
% UPDATED .... [Jan 15]
% evaluate the roots of a given function by Newton's method
% INPUT
%   f       ....   The function that you want to solve.
%   df      ....   The derivative of the function that you want to solve.
%   x0      ....   The initial guess
%   tol     ....   The tolerance specifying the accuracy wanted in the solution
%   maxIter ....   The maximum number of iterations allowed
% =========================================================================

function N = newtonsMethod(f, df, x0, tol, maxIter)

    % Initialize the first two values
    x=x0;
    xprev=0;

    % Create a vector that stores 0 only with the length of maxIter
    N=zeros(1,maxIter);

    % define k as the element in the vector to place x into
    k = 0;  
  
    % loop the function while abs(x-xprev) is greater than the tolerance,
    % and the number of iterations is smaller than the maximum defined
    while abs(x-xprev) > tol & k <maxIter
    
        % add one to the value of k
        k = k + 1;
        
        % insert value of x(n) into the kth element of the vector
        N(k)=x;
        
        % definition of Newton's method
        xprev = x;
        x = x - f(x)/df(x);
    
    end

    % delete the tail zeros in the vector
    N=N(1:k);
    
    format long

end

    