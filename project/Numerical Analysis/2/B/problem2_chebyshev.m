
    %create vector 
    che=linspace(0,999,1000);
    %Chebyshev nodes for x
    chenode=(3/2) + (1/2)*cos(pi*(1-che/999));
    chegamma=gamma(chenode);
    %create Chebyshev nodes with n = 9
    number=[9 17 19];
    for i=1:length(number)
            node=linspace(0,number(i),number(i)+1);
            tau=(3/2) + (1/2)*cos(pi*(1-node/number(i)));
            name='Chebyshev nodes';
            l=1;
            figure((i-1)*4+l)
            rho=gamma(tau);
            p=secondbaryeval(tau,rho,chenode);
            plot(chenode,p,'r')
            xlabel('x')
            ylabel('y')
            title([name ' interpolant for n=',num2str(number(i))])
            hold on
            plot(tau,rho,'o')
            figure((i-1)*4+l+1)
            plot(chenode,abs(chegamma-p))
            xlabel('x');
            ylabel('y');
            title({['Error in ' name ];[' interpolant for n=' num2str(number(i))]})
    %question 3
            V=vander(tau);
            rhoR=rho.';
            a = V\rhoR;
            y=polyval(a,chenode);
            figure((i-1)*4+l+2)
            plot(chenode,y)
            xlabel('x');
            ylabel('y');
            title({[name ' interpolant  expressed in '];['the monomial basis for n=' num2str(number(i))]})
            hold on
            plot(tau,rho,'o')
            %question 4
            figure((i-1)*4+l+3)
            plot(chenode,abs(chegamma-y))
            xlabel('x');
            ylabel('y');
            title({['Error in ' name ' interpolant '];[' expressed in the monomial basis for n=' num2str(number(i))]})
            if i==3  
                    %gamma 5/2
                    disp('rho(5/2) by  secondbaryeval interpolant directly') 
                        secondbaryeval(tau,rho,5/2) 
                    disp('rho(5/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        3/2*secondbaryeval(tau,rho,3/2) 
                    disp('gamma(5/2)') ;
                        gamma(5/2) 
                    disp('error for rho(5/2) by  secondbaryeval interpolant directly') 
                        abs(gamma(5/2)-secondbaryeval(tau,rho,5/2))
                    disp('error for rho(5/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        abs(gamma(5/2)- 3/2*secondbaryeval(tau,rho,3/2)) 
                    %gamma 7/2 
                    disp('rho(7/2) by  secondbaryeval interpolant directly') 
                        secondbaryeval(tau,rho,7/2) 
                    disp('rho(7/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        (5/2)*(3/2)*secondbaryeval(tau,rho,3/2)   
                    disp('gamma(7/2)') ;
                        gamma(7/2) 
                    disp('error for rho(7/2) by  secondbaryeval interpolant directly') 
                        abs(gamma(7/2)-secondbaryeval(tau,rho,7/2))
                    disp('error for rho(7/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        abs(gamma(7/2)- (5/2)*(3/2)*secondbaryeval(tau,rho,3/2))
                    %gamma 9/2
                    disp('rho(9/2) by  secondbaryeval interpolant directly') 
                        secondbaryeval(tau,rho,9/2)
                    disp('rho(9/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        7/2*5/2*3/2*secondbaryeval(tau,rho,3/2) 
                    disp('gamma(9/2)') ;
                        gamma(9/2) 
                    disp('error for rho(9/2) by  secondbaryeval interpolant directly') 
                        abs(gamma(9/2)-secondbaryeval(tau,rho,9/2))
                    disp('error for rho(9/2) by gamma(1+z)=z*gamma(z) where z is in [1,2]') 
                        abs(gamma(9/2)- (7/2)*(5/2)*(3/2)*secondbaryeval(tau,rho,3/2))
            end
    end
   

    
    


  
    