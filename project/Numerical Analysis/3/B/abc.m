x = -2:1:2
y = -2:1:2
[X,Y] = meshgrid(x,y);
Z = 2*sin(X.*Y)