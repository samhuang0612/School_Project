% =========================================================================
% AUTHOR ..... Huang, Lishan  Han, Jiarong Brown, Fraser Chen, Yushan 
% DATE .... March 22
%
% Description: Analysis test for Squire-Trapp formular
% =========================================================================
%%
% *Script*
close all
clear all
%%
% definition of the Bessel functions
    J = @(n, z) integral(@(t) cos(n*t - z*sin(t)), 0, pi)/pi;
    
    %Gien x to be tested
    x=22.3;
    
    %Given value of h
    h=logspace(-14,0,2019);
    
    % definiton of the derivative of the Bessel functions by using the
    % Squire-Trapp formular
    jn = @(n,x)( n * J (n, x) / x) -J (n+1 , x);
    
     % definiton of the derivative of the Bessel functions by using the
     % built-in besselj
    bessel=@(n,x) ( n * besselj(n,x) / x) -besselj(n+1,x);
    
    %create output matrix to store the errors 
    img = zeros(3,2019);
    img1 = zeros(3,2019);
    img2 = zeros(3,2019);
    img3 = zeros(3,2019);
    
    % calculate the error for n= 0, 1, 2
    for i =1:3
        
        n=i-1;
        
        %loop the given h to calculater the errors
        for k=1:2019
            
            %error of the Squire-Trapp formula 
            img(i,k) = abs(imag(J(n,x+1i*h(k))/h(k))- jn (n,x));
            
            %error of the built-in besselj
            img1(i,k) = abs(imag(besselj(n,x+1i*h(k))/h(k)) - bessel(n,x));
            
            %error of the central difference formula;
            img2(i,k) = abs((J(n,x+h(k)) -J(n,x-h(k)))/(2*h(k)) - jn(n,x));
            
            %error of the fourth-order formula
            img3(i,k) =abs((imag(J(n,x+1i*h(k))/h(k))+ (J(n,x+h(k)) -J(n,x-h(k)))/(2*h(k)))/2 - jn (n,x));
            
        end
        
        figure(i)
        %plot error 
        loglog (h,img(i,:),'r-',h,img1(i,:),'b-',h,img2(i,:),'m-',h,img3(i,:),'k-')  
        legend("The Squire-Trapp formula","The built-in besselj","The central difference formula"," fourth-order formula")
        title(["Error for different method when n =",n])
        xlabel("x")
        ylabel("y")
        
    end
   

    
