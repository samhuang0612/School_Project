% =========================================================================
% AUTHOR ..... [Huang Lishan, Yang, Wenshuo, Hoffman, Nicholas, Tamkee, Michael]
% UPDATED .... [Jan 18]
% Provide the results for each of the 3 tasks
%%
% *newtons Method *
%
% newtonsMethod.m
%
% <include>newtonsMethod.m</include>
%%
% *secant Method *
%
% secantMethod.m
%
% <include>secantMethod.m</include>
%% task 1
clf;
close all;
clear all;

disp('*TASK 1*')

format long

% Define the function
f = @(x) (x + 1).*(x - 1/2);
df = @(x) 2*x + 1/2;
x0 = -1.2;
x1 = -0.9;
x2 = 0.4;
x3 = 0.6;
tol = 1e-20;
maxIter = 20;

% Find roots using the Newton's method
task1_newton_root1 = newtonsMethod(f, df, x0, tol, maxIter)
task1_newton_root2 = newtonsMethod(f, df, x2, tol, maxIter)

% Find roots using the secant method
task1_secant_root1 = secantMethod(f, x0, x1, tol, maxIter)
task1_secant_root2 = secantMethod(f, x2, x3, tol, maxIter)

%% task 2
clf;
close all;
clear all;

disp('*TASK 2*')

format long

% Define the function
f = @(y) y^3-2*y-5;
df = @(y) 3*y^2 - 2;
y0 = 2;
y1 = 2.1;
tol = -1;
maxIter = 7;

% Finding roots using different methods

    % Find a root using Newton's method
    task2_newton = newtonsMethod(f, df, y0, tol, maxIter)
   
    % Find a root using the secant method
    task2_secant = secantMethod(f,y0,y1, tol, maxIter)
    
    % Find roots using the roots function
    p = [1 0 -2 -5];    
    task2_roots=roots(p)

% Find the roots when the intial guess is 1i

y0 = 1i;
    
    % For Newton's method - increase MaxIter -> 10 to allow convergence to
    % the roots method
    task2_newton_1i = newtonsMethod(f, df, y0, tol, 10)

%% task 3
clf;
close all;
clear all;

disp('*TASK 3*')

format long

% Define the variables
M= 174.796 * pi / 180;
e = 0.205630;
K = @(E) E - e * sin(E) - M;
dK =@(E) 1- e * cos(E);
ddK =@(E) e * sin(E);
E0=M;
E1= M + e*sin(M);
tol = 1e-20;
maxIter = 20;

% Perform Newton's Method

    % Define the function
    x_newton = newtonsMethod(K, dK, E0, tol, maxIter);

    % take the last value of the output that is closest to the convergence
    task3_newtonsMethod=x_newton(length(x_newton))


% Perform Halley's method

    % Define additional variables
    x=E0;
    xprev=0;

    % Set up Halley's method
        k = 0;
        N=zeros(1,maxIter);
            while abs(x - xprev) > tol & k < maxIter
                k = k + 1;
                N(k)=x;
                %definition of Halley's method
                xprev = x;
                x = x - K(x)/(dK(x)-0.5 * K(x) * ddK(x)/dK(x));
            end
        
        %delete the tail zeros value
        x_Halley=N(1:k);

    % End of Halley's method function

    %take the last value of the output that closest to the covergence
    task3_halleysMethod=x_Halley(length(x_Halley))
        
% Perform the Secant Method       
    
    % Define the Secant method function
    x_secant = secantMethod(K, E0, E1, tol, maxIter);

    %take the last value of the output that closest to the covergence
    task3_secantMethod=x_secant(length(x_secant))

% plot Mercury's orbit

    disp('*Plotting Mercurys orbit around the Sun using Newtons method*')

    % initialize the input value
    T = 87.9691;
    t0 = 0;
    t=linspace(1, 100 ,100 );
    M0 =174.796*pi/180;
    M= 2*pi.*(t-t0)./T+M0;
    E_value = zeros(1,length(M));
    
    %use for loop to compute E of corresponding value of M and store it into
    %the zeros vector
        for t=1:length(M)
            K = @(E) E - e * sin(E) - M(t);
            dK =@(E) 1- e * cos(E);
            a=newtonsMethod(K, dK, M(t), tol, maxIter);
            E_value(t)=a(length(a));
        end
        
    % define a and compute b
    a = 0.387098;
    b=sqrt(a^2-(a*e)^2);
    
    % define functions of x and y
    x = a*(cos(E_value) - e);
    y = b*sin(E_value);
    
    % plot the orbit of Merury around the Sun
    plot(x,y,'k.',0,0,'y*')
    title('The coordinates of Mercury as it is orbiting around the Sun')
    legend('Orbiting of Mercury','Sun')
    xlabel('x')
    ylabel('y')

