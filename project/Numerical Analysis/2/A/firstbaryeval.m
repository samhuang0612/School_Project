% =========================================================================
% AUTHOR ..... [Lishan Huang]
% UPDATED .... [Jan 23]
%
%  Evaluate the first form of the barycentric formula
%
% INPUT
% tau .... The vector of interpolation nodes (length n)
% rho .... The vector of values at the interpolation nodes (length n)
% x   .... A vector of values to evaluate the interpolating polynomial at (length 1 to many (probably not n!))
%
% OUTPUT
% T :
% =========================================================================

function T = firstbaryeval(tau, rho, x)
%initialize t p T and a 
    t=tau;
    p=rho;
    T=0;
    a=1;
    %calculate w(x) and store in a
        for k=1:length(t)
            a=a.*(x-t(k));
        end
    %create for loop to add up the function
        for k=1:length(t)
            b=1;
            %for loop for b(k)
            for j=1:length(t)
               if j~=k
                   b=b.*((t(k)-t(j))).^-1; 
               end
            end
            T=T+b.*p(k)./(x-t(k));
        end
    T=T.*a;
end


        

