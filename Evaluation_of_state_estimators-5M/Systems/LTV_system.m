%% The discrete-time linear time invariant system
% x(k+1)=Ax(k)+Bu(k)+w(k);
% y(k)=Cx(k)+d(k);
A = cell(1,k);E = cell(1,k);F = cell(1,k);
for i=1:k
    t = 2*pi*rand(1)-pi;
    A{i} = [cos(t),-sin(t);sin(t),cos(t)];
    E{i} = 2*rand(2,2)-1; F{i} = rand(1);
end
B=[0.0081,-0.0032,-0.0034;0,0.0032,0.0034];
C=[1,1];
%% The uncertainty sets
% x(0)\in X0;w(k)\in W{k};d(k)\in D{k}
x_star=[0.4;0.06];
X0=zonotope(x_star,0.2*eye(2));
W=Polyhedron([0.1,0.1;0.1,-0.1;-0.1,0.1;-0.1,-0.1]);
D=Polyhedron([-0.1;0.1]);
%% The system parameters
% k: Evolution steps; Ns: Number of seeds; 
nx=size(A{1},1); ny=size(C,1); nu=size(B,2);
nw=size(E{1},2); nd=size(F{1},2);u=2*ones(nu,k);