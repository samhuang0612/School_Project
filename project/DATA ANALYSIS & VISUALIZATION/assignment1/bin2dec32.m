function x = bin2dec32(s)
% bin2dec32:
%%convert a 32 bit float to its decimal value
if length(s)==32 % check the range
    x=0;
    a='';
    for i=2:1:9 % find the exponent bits
        a=[a,s(i)];
    end
    b=bin2int8(a);% convert the exponent to decimal
    c=2^b;
    for d=10:1:32  % find the mantissa bits
        if strcmp(s(d),'1')
            x=x+2^(b-d+9); %convert the mantissa to decimal     
        end
    end
    x=x+c;%add up the exponent and mantissa
    if s(1)=='1' % find the sigh bit
        x=-x;
    end
else 
    fprintf 'error'
end
    
