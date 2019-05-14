function x = stderr3(A)
%get the average number of each column of matrix A
average=avg3(A);
%get the average number of each column of matrix A
[n,m]=size(A);
%detect whether is  a one row or not
%if is, transfer it into a column
if n==1 && m >1
    A=A';
    B=n;
    n=m;
    m=B;
end
%use sqrt function to ge the Standard Errors Efficiently 
x=sqrt(sum((A-average).^2)./(n-1));