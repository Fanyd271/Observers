%% Initialize the system dynamics
addpath('.\Toolbox')
addpath('.\Systems')
T_avg=zeros(3,50,21);
Err=zeros(2,50,21);fault_num=1;warning_num=1;
Facets_num=zeros(1,50,21);Vertexs_num=zeros(1,50,21);
for k = 11:1:31
    num=1;
    while num<=50
        Four_tank;
       %% Seeds generation
        x0=x_star+(rand(4,1)-0.5);
        x=zeros(nx,k+1);y=zeros(ny,k);x(:,1)=x0;
        w=0.2*rand(nw,k)-0.1;d=0.2*rand(nd,k)-0.1;
        for j=1:k
            x(:,j+1)=A*x(:,j)+B*u(:,j)+E*w(:,j);
            y(:,j)=C*x(:,j)+F*d(:,j);
        end
       %% Compute the bundle of Set-Valued observers (SVOs)
        repeat_num=1;
        while repeat_num<=3 % Reduce the effects of instability of MPT3
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
                if repeat_num==3 
                    save(['Error_data_fourtank\',num2str(fault_num),'.mat']);
                    fault_num=fault_num+1;
                    repeat_num=repeat_num+1;
                else
                    repeat_num=repeat_num+1;
                end
                continue
            end
            Verification;
            if max(Error_1)>=10^(-4) || max(Error_2)>=10^(-4)
                if repeat_num==3
                    save(['Warning_data_fourtank\',num2str(warning_num),'.mat']);
                    warning_num=warning_num+1;
                    repeat_num=repeat_num+1;
                else
                    repeat_num=repeat_num+1;
                end
                continue
            else
                T_avg(1,num,k-10)=t0; T_avg(2,num,k-10)=t1; T_avg(3,num,k-10)=t2;
                Err(1,num,k-10)=max(Error_1);Err(2,num,k-10)=max(Error_2);
                Facets_num(1,num,k-10)=size(Xm{end}.H,1);
                Vertexs_num(1,num,k-10)=size(Xm{end}.V,1);
                num=num+1;
                disp(['The Algorithm 1 has numerical error ',num2str(max(Error_1))]);
                disp(['The Algorithm 2 has numerical error ',num2str(max(Error_2))]);
                break
            end
        end
    end
end
save('.\data\intense_fourtank.mat');