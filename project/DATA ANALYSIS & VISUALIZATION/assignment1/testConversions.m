%% CS2035B Assignment 1: Testing Integer and Floating Point Conversions
%% Identification
% Your Name: Lishan Huang
% Your Student Number 250777962

%%convert an interger to binary testing. 
bin2int8(int2bin8(11)) 
bin2int8(int2bin8(-11)) 
bin2int8(int2bin8(100)) 

%%convert from binary to integer testing
int2bin8(bin2int8('10101010'))
int2bin8(bin2int8('11101110'))
int2bin8(bin2int8('10001000'))

%%convert a decimal number to a 32 bit float testing
dec2bin32(12.33) 
dec2bin32(-122.12) 
dec2bin32(123.11) 

%%convert a decimal number to a 32 bit float testing
bin2dec32(dec2bin32(321.321)) 
bin2dec32(dec2bin32(-122.123)) 
bin2dec32(dec2bin32(12.321))

%%convert a 32 bit float to its decimal value
dec2bin32(bin2dec32('01010001001100011001100110011001'))
dec2bin32(bin2dec32('11001001001110010001100110011101'))
dec2bin32(bin2dec32('01001001000100011001100110000011'))