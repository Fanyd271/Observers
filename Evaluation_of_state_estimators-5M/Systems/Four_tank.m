%% The discrete-time linear time invariant system
% x(k+1)=Ax(k)+Bu(k)+w(k);
% y(k)=Cx(k)+d(k);
A=[0.9842,0,0.0419,0;0,0.9890,0,0.0333;...
    0,0,0.9581,0;0,0,0,0.9672];
B=[0.2102,0;0,0.0628;0,0.0479;0.0094,0];
C=[0.5,0,0,0;0,0.5,0,0];
%% Uncertainties
E = diag([1,1,1,1]);
F = eye(2,2);
W = zonotope(zeros(4,1),0.1*eye(4,4));
D = zonotope(zeros(2,1),0.1*eye(2,2));
%% Initial sets
x_star=[12.4;12.7;1.8;1.4];Gx0=0.5*eye(4);
X0=zonotope(x_star,Gx0); 
%% The system parameters
% k: Evolution steps; Ns: Number of seeds; 
nx=size(A,1); ny=size(C,1); nu=size(B,2);
nw=size(E,2); nd=size(F,2); u=2*ones(nu,k);