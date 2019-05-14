function s = dec2bin32(x)
% dec2bin32:
%convert a decimal number to a 32 bit float
if abs(x) < 2^-126
    s='0000 0000 0000 0000 0000 0000 0000 0000';
elseif abs(x) >= 2^128
    s='0111 1111 1000 0000 0000 0000 0000 0000';
elseif  abs(x) <=-2^128
    s='1111 1111 1000 0000 0000 0000 0000 0000';
else
    s='';
% set sign bit
    if x>=0
        s=[s,'0'];
    else
        s=[s,'1'];
        x=-x;
    end
% set exponent bits
    n=128;
    while 2^n>=x
        n=n-1;
    end
    a=int2bin8(n);
    s=[s,a];
    x=mod(x,2^n);
    % set mantissa bits
    for i=1:1:23
        if x>2^(n-i)
            x=mod(x,2^(n-i));% extract 'hidden bit' portion of mantissa
            s=[s,'1'];
        else
            s=[s,'0'];
        end
    end
end

