function s = int2bin8(x)
% bin2int8:
% convert an integer x in the range [-127,128] into its binary representation
if -127<=x && x<=128
% distinguish whether x is in the range
% if it is, plus the bias
    s='';
    x=x+127;
 % use for loop to compute remainder of num and 2^i 
 % and concatenate '0' or '1' to s accordingly
    for i =7:-1:0   
        if x>=2^i
            x=mod(x,2^i);
            s=[s,'1'];
        else
            s=[s,'0'];
        end
    end
else
    fprintf('error');
end   


    