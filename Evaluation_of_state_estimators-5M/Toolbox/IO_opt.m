function [S,L_io] = IO_opt(Xm,Xcor,k,A,C)
nx=size(A,1); Ni=2*nx;
v=[eye(nx),-eye(nx)];L_io=cell(Ni,k);S=cell(Ni,k+1);
%% The computation of observer gain
for i=1:Ni
    S{i,end}=eye(nx);
    for j=k:-1:1
        L_io{i,j} = L_opt(v(:,i),Xm{j},Xcor{j},A,C);
        v(:,i)=(A-L_io{i,j}*C)'*v(:,i);
        S{i,j}=Smatrix(v(:,i));
    end
end