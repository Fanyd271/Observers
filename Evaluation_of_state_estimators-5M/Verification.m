%% Use optimization program to evaluate the effectivenss of the algorithms
disp('Checking...');
%% Check the Algorithm 1
H0 = X0.H;Hw = W.H;Hd = D.H;
Hm = Normalize(Xm{end});
Error_1 = zeros(1,size(Hm,1));
Error_3 = zeros(1,size(Hm,1));
for i=1:size(Hm,1)
    v = Hm(i,1:end-1)';
    s1 = Hm(i,end);
    cvx_begin quiet
    cvx_precision best
    variables x_opt(nx,k+1) w_opt(nw,k) d_opt(nd,k)
    maximize(v'*x_opt(:,k+1))
    subject to
        H0(:,1:end-1)*x_opt(:,1) <= H0(:,end);
        Hw(:,1:end-1)*w_opt <= repmat(Hw(:,end),1,k);
        Hd(:,1:end-1)*d_opt <= repmat(Hd(:,end),1,k);
        for j=1:k
            x_opt(:,j+1)==(A-L_svo{i,j}*C)*x_opt(:,j)+B*u(:,j)+E*w_opt(:,j)...
                +L_svo{i,j}*(y(:,j)-F*d_opt(:,j));
        end
    cvx_end;
    s2=cvx_optval;
    Error_1(i)=abs(s1-s2);
    %% Check MPT
    cvx_begin quiet
    cvx_precision best
    variables x_opt(nx,k+1) w_opt(nw,k) d_opt(nd,k)
    maximize(v'*x_opt(:,k+1))
    subject to
        H0(:,1:end-1)*x_opt(:,1) <= H0(:,end);
        Hw(:,1:end-1)*w_opt <= repmat(Hw(:,end),1,k);
        Hd(:,1:end-1)*d_opt <= repmat(Hd(:,end),1,k);
        for j=1:k
            x_opt(:,j+1)==A*x_opt(:,j)+B*u(:,j)+E*w_opt(:,j);
            y(:,j)==C*x_opt(:,j)+F*d_opt(:,j);
        end
    cvx_end;
    s3=cvx_optval;
    Error_3(i)=abs(s1-s3);
end 
%% Check algorithm 2
XBox=Box(X0);HXBox=XBox.H;
WBox=Box(E*W);HWBox=WBox.H;
DBox=Box(-F*D);HDBox=DBox.H;
x_ub=HXBox(1:nx,end);x_lb=-HXBox(nx+1:2*nx,end);
w_ub=HWBox(1:nx,end);w_lb=-HWBox(nx+1:2*nx,end);
d_ub=HDBox(1:ny,end);d_lb=-HDBox(ny+1:2*ny,end);
z_lb = zeros(nx,k+1);z_ub = zeros(nx,k+1);
Error_2=zeros(1,2*nx);
for i=1:2*nx
    v = HXBox(i,1:end-1)';
    s1 = Support_func(Xm{end},v);  
    z_ub(:,1) = max(S{i,1},0)*x_ub-max(-S{i,1},0)*x_lb;
    z_lb(:,1) = max(S{i,1},0)*x_lb-max(-S{i,1},0)*x_ub;
    for j=1:k
        z_ub(:,j+1)=max(S{i,j+1}*(A-L_io{i,j}*C)*S{i,j}^(-1),0)*z_ub(:,j)...
            -max(-S{i,j+1}*(A-L_io{i,j}*C)*S{i,j}^(-1),0)*z_lb(:,j)...
            +S{i,j+1}*B*u(:,j)+max(S{i,j+1},0)*w_ub-max(-S{i,j+1},0)*w_lb...
            +S{i,j+1}*L_io{i,j}*y(:,j)+max(S{i,j+1}*L_io{i,j},0)*d_ub...
            -max(-S{i,j+1}*L_io{i,j},0)*d_lb;
        z_lb(:,j+1)=max(S{i,j+1}*(A-L_io{i,j}*C)*S{i,j}^(-1),0)*z_lb(:,j)...
            -max(-S{i,j+1}*(A-L_io{i,j}*C)*S{i,j}^(-1),0)*z_ub(:,j)...
            +S{i,j+1}*B*u(:,j)+max(S{i,j+1},0)*w_lb-max(-S{i,j+1},0)*w_ub...
            +S{i,j+1}*L_io{i,j}*y(:,j)+max(S{i,j+1}*L_io{i,j},0)*d_lb...
            -max(-S{i,j+1}*L_io{i,j},0)*d_ub;
    end
    if i<=nx
        s2 = z_ub(i,end);
    else
        s2 = -z_lb(i-nx,end);
    end
    Error_2(i)=abs(s1-s2);
end 