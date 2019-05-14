% =========================================================================
% AUTHOR ..... [Huang Lishan, Yang, Wenshuo, Hoffman, Nicholas, Tamkee, Michael]
% UPDATED .... [Jan 15]
% evaluate the roots of a given function by the secant method
% INPUT
%   f       ....   The function that you want to solve.
%   x0      ....   The first initial guess.
%   x1      ....   The second initial guess.
%   tol     ....   The tolerance specifying the accuracy wanted in the solution
%   maxIter ....   The maximum number of iterations allowed
% =========================================================================

function S = secantMethod(f, x0, x1, tol, maxIter)

    % Initialize the first two values
    a=x0;
    b=x1;

    % Create a vector that stores 0 only with the length of maxIter
    S = zeros(1,maxIter);

    % Store the first initial guess into the zeros vector
    S(1) = a;
    
    % Begin k at 1 as the first element of the vector is already filled
    k=1;

    % loop the function as long as abs(b-a) is greater than the tolerance,
    % and the number of iterations is smaller than the maximum defined
    while abs(b-a) > tol & k < maxIter

        % add one to the value of k
        k = k + 1;
        
        % add the new value of x into the kth element of the vector
        S(k) = b;
        
        % definition of secantMethod
        c = a;
        a = b;
        b = a-(f(a)*(a-c)/(f(a)-f(c)));    
    
    end

    % delete the tail zeros in the vector
    S=S(1:k);

end

    