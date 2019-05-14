
% =========================================================================
% secondbaryeval
%
% AUTHOR ..... [Your name]
% UPDATED .... [Today's date]
%
% Evaluates the barycentric formula of the second kind.
%
% INPUT
% tau .... Interpolation nodes
% rho .... Values to be interpolated
% x ...... Points at which to evaluate the interpolating polynomial
%
% OUTPUT
% p .... Value of the interpolating polynomial at points x
% =========================================================================
function p = secondbaryeval(tau, rho, x)
%initialize t p T and a 
    t=tau;
    p=rho;
    T=0;
    F=0;
    %create for loop to add up the function
    exact=zeros(size(x));
    B=bary_weights(t);
        for k=1:length(t)
            %for loop for b(k)
            b=B(k);
            T=T+b.*p(k)./(x-t(k));
            exact(x==tau(k))=rho(k);
        end
        for k=1:length(t)
            b=B(k);
            F=F+b./(x-t(k));
        end
        p=T./F;
        p(isnan(p)==1)=0;
        p=p+exact;
        
end