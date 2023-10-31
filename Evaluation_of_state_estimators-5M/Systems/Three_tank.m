%% The discrete-time linear time invariant system
% x(k+1)=Ax(k)+Bu(k)+w(k);
% y(k)=Cx(k)+d(k);
A=[0.9880,0.0001,0.0109;0.0001,0.9778,0.0114;0.0109,0.0114,0.9776];
B=[0.0065,0;0,0.0063;0,0];
C=[1,0,0;0,1,0];
E = diag([1,1,1]);F = eye(2,2);
W = zonotope(zeros(3,1),0.1*eye(3,3));
D = zonotope(zeros(2,1),0.1*eye(2,2));
%% The uncertainty sets
% x(0)\in X0;w(k)\in W{k};d(k)\in D{k}
x0=[0.4;0.295;0.2]; cx0=[0.4;0.295;0.2];
Gx0=0.5*eye(3);X0=zonotope(cx0,Gx0);
%% The system parameters
% k: Evolution steps; Ns: Number of seeds; 
k=10; Ns=100;nx=size(A,1); ny=size(C,1); nu=size(B,2);
nw=size(E,2); nd=size(F,2); u=zeros(nu,k);