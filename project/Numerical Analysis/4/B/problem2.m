% =========================================================================
% AUTHOR ..... Huang, Lishan  Han, Jiarong Brown, Fraser Chen, Yushan 
% DATE .... March 22
%
% Description: Numerically evaluation for diving case
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
    %total used air next day
    total2=0;
    %total steps to integral 
    n=100000;
    %function to calculate the air used on the day Rob saw a box jellyfish
    f =  @(dt,R) (1+dt/10)*R;
    
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
        %store the sigma part of used air next day
        sigma2=0;

        %calculate the sigma 
            for k=1:n-1
                % if t is between 13  and 23 then r increase to 2 r of the
                % next day which store in sigma two
                R=r;
                if a+h*k>=13 && a+h*k<=23
                    R=2*r;
                end
                
                sigma=A(prof1+dp*k)+sigma;
                sigma2=f(prof1+dp*k,R)+sigma2;
                
            end
            
            % If t between 13 and 23 then r =2r
            left = r;
            right = r;
            
            if a>=13 && a<=23
                left=2*r;
            end
            
            if b>=13 && b<=23
                right=2*r;
            end
            
            %definition of  the Composite Trapezoidal Rule
            total=total+h*(A(prof1) / 2 + A(prof2) / 2 + sigma);
            
            total2=total2+h*(f(prof1,left) / 2 + f(prof2,right) / 2 + sigma2);
            %formular of definition
    end
    
    %display the air used 
    disp(['The air Rob used on the dive is ',num2str(total)])
    diff=total2-total;
    disp(['The extra air used is ',num2str(diff)])
    
    
    for k=1:n-1
        a=t(i);
        b=t(i+1);
        prof1=profile(i);
        prof2=profile(i+1);
        if (( prof1- prof2 ) / (b-a)) >9
            safe="F";
        end
    end
    plot(t,profile)
    title("Depth profile measured at every two minutes")
    xlabel("time")
    ylabel("profile")

%Since we check that there is a difference between two adjacent t with
%corresponding two profile value is 18 so the average is 9 m per
%minute, if it is a straight line, then the rate is 9 per minute which
%does not exceess the limit, however, if the line is no straight ,then
%there will be some point with slope that excesses 9, so it would excess
%the limitation
    
    