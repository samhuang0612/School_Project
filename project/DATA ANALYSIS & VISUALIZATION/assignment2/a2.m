%% CS2035B Assignment 2: Arrays and Efficiency
%% Identificationx
% Your Name: Lishan Huang
% Your Student Number 250777962
%% avg1 Source Code
% <include>avg1.m</include>
%% avg2 Source Code
% <include>avg2.m</include>
%% avg3 Source Code
% <include>avg3.m</include>
%% stderr1 Source Code
% <include>stderr1.m</include>
%% stderr2 Source Code
% <include>stderr2.m</include>
%% stderr3 Source Code
% <include>stderr3.m</include>
%% tests Source Code
% <include>tests.m</include>
%%
x=rand(100,6);
y=rand(1,100);
fprintf("avg1")
avg1(x)
avg1(y)
fprintf("avg2")
avg2(x)
avg2(y)
fprintf("avg3")
avg3(x)
avg3(y)
fprintf("standard output")
mean(x)
mean(y)
fprintf("stderr1")
stderr1(x)
stderr1(y)
fprintf("stderr2")
stderr2(x)
stderr2(y)
fprintf("stderr3")
stderr3(x)
stderr3(y)
fprintf("standard output")
std(x)
std(y)

%% timing Source Code

%initialize the running time of the whole function in pow
pow = 5;
points = pow+1;
m = 1000;
%create a row that contains each result of the whole function run
n = logspace(0,pow,points);
T = zeros(4,points);
for k=1:points
    %initialize a matrix X with m row and n(k) column
    X=rand(m,n(k));
    %each funtion run 10 times
runs=10;
for i=1:runs  
    %get the result of stderr1 with variable matrix X store it in elapsed
    tic
    stderr1(X);
    elapsed(i) = toc;
end
%get the mean of elapsed and store it in the first row
T(1,k) = mean(elapsed);
%print the mean running time
fprintf('stderr1 on %dx%d array: %f s\n',m,n(k),mean(elapsed));

for i=1:runs 
tic
 %get the result of stderr2 with variable matrix X store it in elapsed
stderr2(X);
elapsed(i) = toc;
end
%get the mean of elapsed and store it in the second row
T(2,k) = mean(elapsed);
%print the mean running time
fprintf('stderr2 on %dx%d array: %f s\n',m,n(k),mean(elapsed));

for i=1:runs 
tic
 %get the result of stderr3 with variable matrix X store it in elapsed
stderr3(X);
elapsed(i) = toc;
end
%get the mean of elapsed and store it in the third row
T(3,k) = mean(elapsed);
%print the mean running time
fprintf('stderr3 on %dx%d array: %f s\n',m,n(k),mean(elapsed));

for i=1:runs 
tic
%get the result of matlab function with variable matrix X store it in elapsed
std(X);
elapsed(i) = toc;
end
%get the mean of elapsed and store it in the fourth row
T(4 ,k) = mean(elapsed);
%print the mean running time
fprintf('std     on %dx%d array: %f s\n',m,n(k),mean(elapsed));
end
%plot the result
loglog(n,T)
title('Runtime Comparison for Standard Error Algorithms')
legend ('Variable Array Loops', 'JITC', 'Vectorized','MATLAB')
xlabel('Number of Size 1000x1 Input Columns')
ylabel('runtime')



