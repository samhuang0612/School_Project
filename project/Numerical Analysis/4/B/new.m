% =========================================================================
% AUTHOR .....Huang, Lishan  Han, Jiarong Brown, Fraser Chen, Yushan 
% DATE .... March 22
%
% 
% =========================================================================
%%
% *Script*
clear all
close all
load profile.mat
   %Given definition of function A
    %initial r
    r=15;
    A =  @(dt) (1+dt/10)*r;
    %total used air at first
    total=0;
    total2=0;
    %total steps to integral 
    n=1000000;
    format short 
    %integrating between each adjacent t inside given profile.mat
    
    %calculate integral by using the Composite Trapezoidal Rule
    for i=1:length(t)-1
      
        % get the first t
        a=t(i);
        % get the second t
        b=t(i+1);
        
        % get the corresponding depth profile of a
        prof1=profile(i);
        % get the corresponding depth profile of b
        prof2=profile(i+1);
        
        %calculate the step size of t
        h=(b-a)/n;
        
        %calculate the step size of depth profile
        dp=(prof2-prof1)/n;
        
        %store the sigma part of used air at first
        sigma=0;
        sigma2=0;

        %calculate the sigma 
            for k=1:n-1   
                sigma=A(prof1+dp*k)+sigma;
                if 13<=a+h*k & a+h*k<=23
                    sigma2=sigma2+A(prof1+dp*k);
                end              
            end
            %definition of  the Composite Trapezoidal Rule
            total=total+h*(A(prof1) / 2 + A(prof2) / 2 + sigma);
            target = 0;
            if 13<=a && b<=23
                target = A(prof1) / 2 + A(prof2) / 2;
            end
            total2 = total2 + h*(sigma2 +target);
    end
    
    %display the air used 
    disp(['The air Rob used on the dive is ',num2str(total)])

%Since we check that there is a difference between two adjacent t with
%corresponding two profile value is 18 so the average is 9 m per
%minute, if it is a straight line, then the rate is 9 per minute which
%does not exceess the limit, however, if the line is no straight ,then
%there will be some point with slope that excesses 9, so it would excess
%the limitation
    
    