nx = 4;
T = RandOrthMat(nx);
C = [eye(2),zeros(2,nx-2)];
Eig = 0.5+0.5*rand(1,nx);
A = T*diag(Eig)*T^(-1);
save('A.mat');
