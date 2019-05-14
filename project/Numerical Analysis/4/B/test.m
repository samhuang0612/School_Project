%%
x=zeros(1,10000);
t=x;
dx=x;
x(1)=0.5;
i=1;
h=0.01;
tol=0.001;
while (t(i)<=5)
    x(i+1)=x(i)+h*cos(pi*x(i)*t(i)); %Explicit
    if abs(cos(pi*(t(i)+h)*x(i+1))-cos(pi*t(i)*x(i)))>tol
        h=h/2;
    else
        t(i+1)=t(i)+h;
        dx(i)=(x(i+1)-x(i))/h;
        i=i+1;
        h=0.01;
    end
end
x=x(1:i);
dx=dx(1:i);
t=t(1:i);
plot(t,x,'k',t,z,'--')
figure(2)
res=abs(dx-cos(pi.*t.*x));
semilogy(t,res,'k')