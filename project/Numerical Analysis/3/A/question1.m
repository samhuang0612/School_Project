% Author : Lishan Huang
% Created : Feburary 5, 2019
% Last Updated : Feb 5, 2019
% AM2811 lab3A
%
%
% ===========
% clear figures, close plot windows, clear variables
clf;
close all;
clear all;
%%
%Problem 1
%Solve the system using different method
%create matrix of coefficient
coef=[2, -1 , 3 , 4; 1, 0, -2, 7; 3, -3, 1, 5; 2, 1, 4, 4];
%create vector of right side
solu=[9;11;8;10];
%Solve the system by backslash
disp('Solve the system by backslash')
ans1=coef\solu
%Solve the system by inverse function
coefinv=inv(coef);
disp('Solve the system by inverse function')
ans2=coefinv*solu
%Solve the system by QR function
[q,r]=qr(coef);
disp('Solve the system by QR function')
ans3=r\(q'*solu)
%%
%Problem 2
%Generate a random matrix A of size 3000 × 3000
A=rand(3000);
%Generate a random vector b of size 3000 × 1.
b=rand(3000,1);

disp('time for  \ directly  repeating in 3 time ')
%begin to time
    tic
    %use for loop for repeating 3 time
    for i=1:3
        ans1=A\b;
    end
    toc
%end time
disp('scaled residuals of the solutions by \')
%diplay scaled residuals of the solutions by \
Scale1=norm(b-A*ans1)/norm(b)

disp('time for inverse repeating in 3 time')
%begin to time 
    tic
    %use for loop for repeating 3 time
    for i=1:3
        ans2=inv(A)*b;
    end
    toc
%end time
display('scaled residuals of the solutions by inverse')
%diplay scaled residuals of the solutions by inverse
Scale2=norm(b-A*ans2)/norm(b)

display('time for qr repeating in 3 time')
%begin to time
    tic
        %use for loop for repeating 3 time
    for i=1:3
        [q,r]=qr(A);
        ans3=r\(q'*b);
    end
%end time
    toc
[q,r]=qr(A);
ans3=r\(q'*b);
display('scaled residuals of the solutions by qr')
%diplay scaled residuals of the solutions by qr
Scale3=norm(b-A*ans3)/norm(b)

% using the backslash operator is the fastest method to solve the linear
% system with largest scaled residual while using QR decomposition is the 
% slowest method with smallest scaled residual.
%%
%Problem 3
%Create a 6000 × 3000 matrix A first 3000 rows are random, and the second
%3000 rows repeat the first 3000.
A=rand(3000,3000);
A=[A;A];
%Create a 6000 × 1 random vector b
b=rand(6000,1);
%Create the augmented matrix 
C=[A b];
%since the second 3000 rows repeat the first 3000, then the last
%3000 rows must be dependent of the first 3000 rows, so the rank of this
%matrix is less than or equal to 3000 and no equal to the size of solution
%vector, so this system has no solution
solu1=A\b;
% scaled residuals of calculated by \
disp('scaled residuals of calculated by \')
norm(b-A*solu1)/norm(b)
solu2=(A'*A)\(A'*b);
% scaled residuals calculated by normal equations
disp('scaled residuals of calculated by normal equations')
norm(b-A*solu2)/norm(b)
%
%the result in the normal equations is same as the result in backlash 
%operator since in the normal equation method,A' is eliminated in numerator 
%and denominator and also the error of A' , thus the solution in  in 
%backlash operator is same as in normal equation method, and also their
%norm.
%%
%Problem 4
%create a 20×20 matrix 
A=rand(20);
b=rand(20,1);
%replace the last row as the second last row, so it must be linear
%combination of the second last row
B=[A(1:19,:);A(19,:)];
%determinant of this singular matrix
disp('determinant of this matrix')
det(B);
disp(det(B))
disp('solution of this matrix')
solu=B\b
%the determinant may be zero or a very smalle number, if there is no 
%roundoff errror in the the elimination process such that the second last 
%row eliminate the last row directly at first, then the last row will be 
%zero, then the determinant will be 0. if the last row or second last row 
%has been eliminated by other rows before eliminating each other and a 
%roundoff error occurs, then the last row is not equal to the second last 
%row anymore due to the roundoff error, so it is a nonsingular matrix and 
%the determinant will not be 0.
%%
%Problem 5
%create a 20×20 matrix 
A=rand(20);
%determinant of A
disp('determinant of matrix A')
det(A)
disp('The determinant is not zero')
%divide the matrix by 10 
B=A/10;
%determinant of A divide by 10
disp('determinant of matrix A after dividing by 10')
det(B)
%No?a small determinant is not a good indicator of a singular matrix. 
%since the roundoff error may coursed by formulas that involve roundoff 
%error, convert to floating point arithmetic or roundoff errors in 
%Gaussian elimination. Then the singular matrix may be no longer a singular
%matrix due to the roundoff error but very closed, then the roundoff error
%will cause a smalle determinant. However, a smaller determinant is
%necessary to be casued by roundoff error, if the sizes of the elements in
%the matrix are very small, then it also result in a small determinant. But
%small determinant of a singular matrix will be very close to 1*e-18 while a
%the determinant of small size matrix can be much samller than that?




