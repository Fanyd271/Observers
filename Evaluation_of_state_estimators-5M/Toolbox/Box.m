function B=Box(Z)
V=Z.V; nx = size(V,2);
lb = zeros(nx,1);
ub = zeros(nx,1);
for i=1:nx
    lb(i) = min(V(:,i));
    ub(i) = max(V(:,i));
end
H = [eye(nx);-eye(nx)];
B = Polyhedron(H,[ub;-lb]);
