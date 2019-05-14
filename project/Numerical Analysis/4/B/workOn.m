function sum = workOn(x)
    y = @(u) cos(u^2);
    f = @(y) sqrt(-2*log(y))/acos(y);
    
    sum=0;
    n=1000000;
    
    a=0;
    b=x;

    if b~=0
      
        f1=1;
            if y(a)~=1
                f1=f(y(a));
            end 
            
        f2=1;
            if y(b)~=1
                f2=f(y(b));
            end
            
        h=(b-a)/n;
        sigma=0;
        
            for k=1:n-1
                
                target=1;
                
                if y(a+h*k)~=1
                    target=f(y(a+h*k));
                end
            
                sigma=target+sigma;
                
            end
            
        sum=h*(0.5*f1 + 0.5*f2 + sigma)/b;
        
    else
        
        sum=1;
        
    end
    
end



        %formular of definition
