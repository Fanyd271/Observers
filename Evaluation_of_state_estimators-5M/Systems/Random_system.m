%% The discrete-time linear time invariant system
% Random_system_generating % Run this line to generate a random system
load('A.mat');
B = zeros(nx,2);
%% Simplified
E = eye(nx);
F = 0.2*eye(2);
W = zonotope(zeros(nx,1),0.1*eye(nx));
D = zonotope(zeros(2,1),0.1*eye(2));
%% The uncertainty sets
% x(0)\in X0;w(k)\in W{k};d(k)\in D{k}
x0=zeros(nx,1); 
cx0=x0;Gx0=0.5*eye(nx);
X0=zonotope(cx0,Gx0);
%% The system parameters
% k: Evolution steps; Ns: Number of seeds; 
k = 3; nx=size(A,1); ny=size(C,1); nu=size(B,2);
nw=size(E,2); nd=size(F,2); u=zeros(nu,k);