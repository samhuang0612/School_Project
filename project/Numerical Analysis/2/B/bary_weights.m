%----------------------------------------------------------------------
%
% FUNCTION: bary_weights
%
% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.
%
% Compute the barycentric weights w for the points tau, 
% scaled such that norm(W,inf) == 1.
%
% INPUT:
%    tau ... points to compute weights from
%
% OUTPUT:
%     w ... barycentric weights
%
%----------------------------------------------------------------------
function w = bary_weights(tau)

n = length(tau);

if isreal(tau)
    C = 4/(max(tau)-min(tau)); % Capacity of interval
else
    C = 1;                   % Scaling by capacity doesn't apply for complex nodes
end

if n < 2001                  % For small n using matrices is faster
   V = C*bsxfun(@minus,tau,tau.');
   V(logical(eye(n))) = 1;
   VV = exp(sum(log(abs(V))));
   w = 1./(prod(sign(V)).*VV).';
else                         % For large n use a loop
   w = ones(n,1);
   for j = 1:n
       v = C*(tau(j)-tau); v(j) = 1;
       vv = exp(sum(log(abs(v))));
       w(j) = 1./(prod(sign(v))*vv);
   end
end
% Scaling
w = w./max(abs(w));
