function set_zono=zonotope(c,H)
num=size(H,2);   % Calculate the vertices of zonotope
vert=[];
for k=1:num   
    temp=ones(1,2^(k-1));
    vert=[temp -temp;vert vert];
end
vert=H*vert+c;
vert_X=vert';
set_zono=mRep(Polyhedron(vert_X));