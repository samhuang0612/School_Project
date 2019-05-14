function x = bin2int8(s)
% bin2int8:
% convert from binary to integer.
x=0;
 % whether the range of coresponding integer is in[-128,128]
if length(s)==8
 %for loop the add up each number stand for
    for i =1:1:8
        if strcmp(s(i),'1')
            x=x+2^(8-i);      
        end
    end
    % plus the bias
    x=x-127;
else 
    fprintf 'error'
end
    
            