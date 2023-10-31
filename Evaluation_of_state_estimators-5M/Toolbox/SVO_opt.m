function L_svo=SVO_opt(Xm,Xcor,k,A,C)
H=Xm{end}.minHRep.H(:,1:end-1);
Ns=size(H,1);
v=H';L_svo=cell(Ns,k);
%% The computation of observer gains
for i=1:Ns
    for j=k:-1:1
        L_svo{i,j} = L_opt(v(:,i),Xm{j},Xcor{j},A,C); 
        v(:,i)=(A-L_svo{i,j}*C)'*v(:,i);
    end
end