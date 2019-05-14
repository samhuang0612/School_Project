% Author : Lishan Huang?Chen Yushan ,Lin Shichen,Tamkee  Michael
% Created : Feburary 14, 2019
% Last Updated : Feb 14, 2019
% AM2811 lab3B
%Modified Gram-Schmidt (MGS) for computing the QR factoring by recursion
%
%
% ===========
function [Q,R] = RecursiveMGS(X)
%create Q R by zeros
    [n,p] = size(X);
    Q = zeros(n,p);
    R = zeros(p,p);
    input=X;
    Q(:,p) = input(:,p);
    %if the size is larger than 1 then call recusive
    if 1<p
        input=input(:,1:p-1);
        %call recursion for smaller matrix
        [A,B]=RecursiveMGS(input);
        Q(:,1:p-1)=A;
        R(1:p-1,1:p-1)=B;
        %calculate row
        for i = 1:p-1
            R(i,p) = Q(:,i)'*Q(:,p);
            Q(:,p) = Q(:,p) - R(i,p)*Q(:,i);
        end
    end
    R(p,p) = norm(Q(:,p))';
    Q(:,p) = Q(:,p)/R(p,p); 
end

