n=3
z=-1i+2
a=integral(@(x)exp(z.*cos(x)).*cos(n.*x)/pi,0,pi)
function M =myin(z,n)
k=pi./10;
x=0:k:pi;
N=length(x);
f=@(x) exp(z,+cos(s)).*cos(n.*s);
for i=1:n
    M=M+f((x(i)+x(i+1))/2).*k;
end
M=M./pi