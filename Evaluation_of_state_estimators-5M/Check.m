addpath('.\Toolbox');
addpath('.\Systems');
%% Skip this block when verifying an available experimental result
k=21;
Two_tank; % Select the evaluated system
x0=x_star;
x=zeros(nx,k+1);y=zeros(ny,k);x(:,1)=x0;
w=0.2*rand(nw,k)-0.1;d=0.2*rand(nd,k)-0.1;
for j=1:k
    x(:,j+1)=A*x(:,j)+B*u(:,j)+E*w(:,j);
    y(:,j)=C*x(:,j)+F*d(:,j);
end
%% Compute the bundle of Set-Valued observers (SVOs)
Error_flag = 0;
try
    t=tic;
    Xm=cell(1,k+1);Y=cell(1,k);Xmy=cell(1,k);Xm{1}=X0;
    Xcor=cell(1,k);
    for j=1:k % SME
        Y{j}=y(:,j)+(-F*D); 
        H_Y=Y{j}.minHRep.H(:,1:end-1);b_Y=Y{j}.minHRep.H(:,end);
        Xmy{j}=mRep(Polyhedron(H_Y*C,b_Y)); %Eliminate redundant constraints
        Xcor{j}=mRep(Xm{j}.intersect(Xmy{j}));
        Xm{j+1}=mRep(mRep(A*Xcor{j})+B*u(:,j)+mRep(E*W));
    end
    t0=toc(t);
    t_svo=tic;
    L_svo = SVO_opt(Xm,Xcor,k,A,C); 
    t1=toc(t_svo);
    %% Compute the bundle of interval observers (IOs)
    t_io=tic;
    [S,L_io] = IO_opt(Xm,Xcor,k,A,C);
    t2=toc(t_io);
catch
    Error_flag=1;
end
Verification;
disp(['The Algorithm 1 has numerical error ',num2str(max(Error_1))]);
disp(['The Algorithm 2 has numerical error ',num2str(max(Error_2))]);
%% Plot the 2D or 3D sets
Compute_SESs;
Plot_sets;