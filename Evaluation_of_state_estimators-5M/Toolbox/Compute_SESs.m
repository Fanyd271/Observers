Ns = size(L_svo, 1); % Number of required SVOs
Xp=cell(Ns,k);
%% Multi-processing for computing X_{k+1}^P
% Xp_para=cell(1,Ns);
% for i=1:Ns
%     Xp_para{i}=X0;
%     Xp{i,1}=X0;
% end
% for j=1:k
%     parfor i=1:Ns % SVO
%         Xp_para{i}=mRep(mRep((A-L_svo{i,j}*C)*Xp_para{i}+L_svo{i,j}*Y{j})...
%             +B*u(:,j)+mRep(E*W));
%     end
%     for i=1:Ns
%         Xp{i,j+1}=Xp_para{i};
%     end
%     disp(['Step ',num2str(j),' is finishied.']);
% end
%% Single threading for computing X_{k+1}^P
for i=1:Ns 
    Xp{i,1}=X0;
    for j=1:k
        Xp{i,j+1}=mRep(mRep((A-L_svo{i,j}*C)*Xp{i,j})+B*u(:,j)+...
            mRep(E*W+L_svo{i,j}*Y{j}));
    end
end
%% Compute the intervals X_{k+1}^I
Ni = size(L_io,1); % Number of required IOs
Zi=cell(Ni,k);
for i=1:Ni % SVO
    Zi{i,1}=Box(S{i,1}*X0);
    for j=1:k
        r = rank(A-L_io{i,j}*C);
        if r<nx % Degeneracy affects the computational accuracy
            [U,~,V]=svd(A-L_io{i,j}*C);
            s=svd(A-L_io{i,j}*C);
            S_mat=diag([s(1:r)',zeros(1,nx-r)]);
            Zi{i,j+1}=Box(mRep(S{i,j+1}*U*S_mat*V'*S{i,j}^(-1)*Zi{i,j})+...
                        S{i,j+1}*B*u(:,j)+mRep(S{i,j+1}*L_io{i,j}*Y{j})...
                        +mRep(S{i,j+1}*E*W));
        else
            Zi{i,j+1}=Box(mRep(S{i,j+1}*(A-L_io{i,j}*C)*S{i,j}^(-1)*Zi{i,j})+...
            S{i,j+1}*B*u(:,j)+mRep(S{i,j+1}*L_io{i,j}*Y{j})+mRep(S{i,j+1}*E*W));
        end   
    end
end