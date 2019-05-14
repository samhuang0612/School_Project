function x = stdder2(A)
%get the size of the result of funtion A
[n,m]=size(A);
%get the average number of each column of matrix A
average=avg3(A);
[a,b]=size(average);
%detect whether is  a one row or not
%if is, transfer it into a column
if n==1 && m >1
    A=A';
    B=n;
    n=m;
    m=B;
end
%initialize the size and the element type of x
x=zeros(1,m);
%Computing Standard Errors Efficiently by for loop
for i=1:m
    dif=0;
      %sum up the different between the value of each element and the average
    %number
    for a=1:n
        dif=dif+(average(1,i)-A(a,i))^2;
    end
    %calculate the square root of the sum devides n-1
    x(i)=sqrt(dif/(n-1));
end
    
        




    
        
