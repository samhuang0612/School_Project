function x = avg2(A)
%get the size of matrix
[n,m]=size(A);
%detect whether is a one row matrix or not
if n==1 && m >1
    A=A';
    b=n;
    n=m;
    m=b;
end
%initialize the size and the type of output
x=zeros(1,m);
%for loop the get the average of each column
for i=1:m
    sum=0;
    for a=1:n
        sum=sum+A(a,i);
    end
    x(i)=sum/n;
end
    
        
