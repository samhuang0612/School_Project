function x = avg1(A)
%get the size of matrix A
[n,m]=size(A);
%create a array with empty infomation
x=[];
%detect whether is  a one row or not
%if is, transfer it into a column
if n==1 && m >1
    A=A';
    b=n;
    n=m;
    m=b;
end
%use for loop the get the sum of each column
for i=1:m
    sum=0;
    %the sum of column
    for a=1:n
        sum=sum+A(a,i);
    end
    %return the average of each column
    x(i)=sum/n;
end
    
        
