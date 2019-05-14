% =========================================================================
% AUTHOR ..... [Yunting Shao]
% UPDATED .... [Feb 7]
%
%
%
% =========================================================================
%define the singular matrix
singulaM=rand(4,5);
singulaM(end+1,:)=sum(singulaM);
DetsingulaM=det(singulaM);
%display determinant
fprintf('The determinant is \n');
disp(DetsingulaM);
% solve 
c=rand(5,1);
x=singulaM\c;
% Display
fprintf('A= \n');
disp(singulaM);
fprintf(' B= \n');
disp(c);
fprintf('The solution of Ax=B is \n');
disp(x);