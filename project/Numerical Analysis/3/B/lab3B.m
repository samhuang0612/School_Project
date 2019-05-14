% Author : Lishan Huang, Chen Yushan ,Lin Shichen,Tamkee  Michael
% Created : Feburary 14, 2019
% Last Updated : Feb 14, 2019
% AM2811 lab3B
%explore the numerical stability of one kind of QR factoring, then explore the SVD,
%then condition number,
%
%
% ===========
% clear figures, close plot windows, clear variables
%%
%Problem 1
%question 1
%Recursive MGS for computing the QR factoring
%create matrix A
A=[1,2,3,4;5,6,7,8;9,10,11,12;13,14,15,16];
%solve Q R by recursive function
[Q,R]=RecursiveMGS(A);
%display Q R
disp("Q for first question")
Q
disp("R for first question")
R
%question 2
%display the norm(A-Q*R) and machine epsilon times nomr A where A in question1 
disp("norm(A-Q*R)")
norm(A-Q*R)
disp("machine epsilon times norm(A)")
eps(1)*norm(A)
%create matrix A1 with elements of widely varying magnitude 
A1=[11111111111111,333,112,0.1111111;444,0.000000002,0.000003333,2;112,333,111111111111111,3;0.11,1233,0.0000001,133333333333333];
%solve in matrix A1 by MGS
[Q1,R1]=RecursiveMGS(A1);
%display the norm(A1-Q1*R1) and machine epsilon times nomr A1 where A1 with elements of widely varying magnitude 
disp("norm(A1-Q1*R1)")
norm(A1-Q1*R1)
disp("machine epsilon times norm(A1)")
eps(1)*norm(A1)

%question 3
%create large Hilbert matrix
A2=hilb(3);
I=eye(3);
%solve A2 
[Q2,R2]=RecursiveMGS(A2);
disp("Recursive for hilb(3) ")
%display norm(Q2'*Q2 - I)
norm(Q2'*Q2 - I)
%display machine epsilon times nomr A2
disp("machine epsilon times hilb(3)")
eps(1)*norm(A2)
%create large Hilbert matrix
A2=hilb(4);
I=eye(4);
%solve A2 
[Q2,R2]=RecursiveMGS(A2);
disp("Recursive for hilb(4) ")
%display norm(Q2'*Q2 - I)
norm(Q2'*Q2 - I)
%display machine epsilon times nomr A2
disp("machine epsilon times hilb(4)")
eps(1)*norm(A2)
A2=hilb(1000);
I=eye(1000);
%solve A2 
[Q2,R2]=RecursiveMGS(A2);
disp("Recursive for hilb(1000) ")
%display norm(Q2'*Q2 - I)
norm(Q2'*Q2 - I)
%display machine epsilon times nomr A2
disp("machine epsilon times norm(A2)")
eps(1)*norm(A2)

%question 4
%solve A2 by QR function directly
disp("QR")
[Q3,R3]=qr(A2);
disp("norm by QR")
norm(Q3'*Q3 - I)

%%
%problem 2
%A 3D (static) version of svdshow
close all
for i=1:4
    %create x,y,z by sphere
    [x,y,z] = sphere();
    %each loop change different A
    if i==1
        A=[1,1,1;1,-1/2,-1/2;1,1/2,-1/2];
        name="first matrix of the image of the unit sphere";
    elseif i==2
        A=hilb(3);
        name="hilb(3) of the image of the unit sphere";
    elseif i==3
        A=[1,2,3;4,5,6;7,8,9];
        name="A[1to9] of the image of the unit sphere";
    elseif i==4
        A=gallery(3);
        name="gallery(3) of the image of the unit sphere";
    end
    %reshape x,y,z in to a 1*n matrix
    x = reshape(x,[],1).';
    y = reshape(y,[],1).';
    z = reshape(z,[],1).';
    %concatate x,y,z to a matrix
    target = [x;y;z];
    target1 = A*target;
    figure(i)
    %get x after the image
    x= target1(1,:);
    y= target1(2,:);
    z= target1(3,:);
    plot3(x,y,z)
    title([name])
    xlabel("x")
    ylabel("y")
    zlabel("z")
    disp("svd of matrix "+name)
    svd(A)
end

%%
%problem 3
%Condition number for solving linear systems
close all
%question1
clear all
%
%define A B deta
A=[1 -2  -2; 0 1 -2; 0 0 1];
b=[1;0;0];
deta=[0;0;0.001];
%calculate x
x=A\b;
%calculate y with deta
y=A\(b+deta);
for i=1:3
    if i==3
        i=inf;
    end
    %if verify the theorem then display true else display false
    if norm(x-y,i)/norm(x,i) <= norm(A,i)*norm(inv(A),i)*norm(deta,i)/norm(b,i)
        disp(i+"-th norm return"+" True")
    else
         disp(i+"-th norm return"+" False")
    end
    
end
%question 2 prove
%create 6 × 6 matrix and 32 × 32 matrix and corresponding b and deta b
A1=ones(6);
A1=A1-tril(A1,-1);
A1=A1-3*triu(A1,1);

A2=ones(32);
A2=A2-tril(A2,-1);
A2=A2-3*triu(A2,1);

b1=zeros(6,1);
b2=zeros(32,1);
b1(1,1)=1;
b2(1,1)=1;
deta1=zeros(6,1);
deta1(6,1)=0.001;
deta2=zeros(32,1);
deta2(32,1)=0.001;
x1=A1\b1;
y1=A1\(b1+deta1);
for i=1:3
    if i==3
        i=inf;
    end
    %if verify the theorem then display true else display false
    if norm(x1-y1,i)/norm(x1,i) <= norm(A1,i)*norm(inv(A1),i)*norm(deta1,i)/norm(b1,i)
        disp(i+"-th norm return"+" True")
    else
         disp(i+"-th norm return"+" False")
    end
    
end
x2=A2\b2;
y2=A2\(b2+deta2);
for i=1:3
    if i==3
        i=inf;
    end
    %if verify the theorem then display true else display false
    if norm(x2-y2,i)/norm(x2,i) <= norm(A2,i)*norm(inv(A2),i)*norm(deta2,i)/norm(b2,i)
        disp(i+"-th norm return"+" True")
    else
         disp(i+"-th norm return"+" False")
    end
    
end
disp("condition number compare")
cond=zeros(1,10);
number=linspace(1,10,10);
for i=1:10
    mat=ones(i);
    mat=mat-tril(mat,-1);
    mat=mat-3*triu(mat,1);
    condition=norm(mat)*norm(inv(mat));
    cond(1,i)=condition;
end
plot(number,cond,number,3.^number)
legend("condition number ","3^n")
title("compare condition number and 3^n")
figure(2)
%question 3
xaxis=linspace(2,60,59);
left=zeros(1,59);
right=zeros(1,59);
%loop for dimensions 2 through 60
for i=2:60
    %create i dimemsion matrix
    %get upper triangle matrix
    A=ones(i);
    A=A-tril(A,-1);
    U=A-3*triu(A,1);
    %define xref
    xref = zeros(i,1);
    xref(1,1)=1;
    %get 
    b = U*xref;
    deta = zeros(i,1);
    deta(i,1)=10^-15;
    y=U\(b+deta);
    norm1=norm(y-xref);
    %if outside of 10^-15 and 10^15 then display no
    if norm1>10^15 || norm1<10^-15
        disp("No")
    end
    %store norm(xref-y)/norm(xref) and norm(A)*norm(inv(A))*norm(deta)/norm(b)
    left(i-1)=norm(xref-y)/norm(xref) ;
    right(i-1)=norm(U)*norm(inv(U))*norm(deta)/norm(b);
end
%plot the different between norm(xref-y)/norm(xref) and norm(A)*norm(inv(A))*norm(deta)/norm(b)
plot(xaxis,left-right)
xlabel("x")
ylabel("y")
title("norm(xref-y)/norm(xref) minus norm(A)*norm(inv(A))*norm(deta)/norm(b)")
figure(3)
%question 4
n=5;
n1=8;
store=[0];
axis=[5];
%calculate for f Fibonacci dimension 5, 8, 13,21, . . . , 377
%store the condition number in store and store n in axis
while n<=377
    A=rand(n);
    cond=norm(A)*norm(inv(A));
    a=n;
    n=n1;
    n1=a+n;
    store=[store,cond];
    axis=[axis,n];
end
%take out the extra data
axis=axis(1,1:length(axis)-1);
store=store(1,2:length(store));
%create vectore for n^2 and n^3
y1=axis.^2;
y2=axis.^3;
%log log plot
loglog(axis,store,axis,y1,axis,y2)
title("k(An) trend compare with n^2 and n^3")
xlabel("x")
ylabel("y")
legend("k(An)","n^2","n^3")
