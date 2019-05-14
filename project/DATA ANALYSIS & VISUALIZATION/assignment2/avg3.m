function x = avg3(A)
%get the size of matrix A
[n,m]=size(A);
%detect whether the matrix is a one row matrix or not
if n==1 && m >1
    A=A';
    b=n;
    n=m;
    m=b;
end
%sum up each column and devide the size of each column
x=sum(A)/n;