%%
x=rand(100,6);
y=rand(1,100);  
%% the value of avg1, avg2, avg3 and mean of X and Y
fprintf("avg1 function of x value")
avg1(x)
fprintf("avg2 function of x value")
avg2(x)
fprintf("avg3 function of x value")
avg3(x)
fprintf("matlab function of x value")
mean(x)

fprintf("avg1 function of y value")
avg1(y)
fprintf("avg2 function of y value")
avg2(y)
fprintf("avg3 function of y value")
avg3(y)
fprintf("matlab function of y value")
mean(y)

%% the value of stderr1, stderr2, stderr3 and function std of X and Y
fprintf("stderr1 function of x value")
stderr1(x)
fprintf("stderr2 function of x value")
stderr2(x)
fprintf("stderr3 function of x value")
stderr3(x)
fprintf("matlab function of x value")
std(x)

fprintf("stderr1 function of y value")
stderr1(y)
fprintf("stderr2 function of y value")
stderr2(y)
fprintf("stderr3 function of y value")
stderr3(y)
fprintf("matlab function of y value")
std(y)