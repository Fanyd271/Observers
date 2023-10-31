function L=L_opt(vector,Xm,Xcor,A,C)
nx=size(A,1);
if norm(vector,"inf")>10^(-15) && ...
        (size(vector,1)~=nx || rank(vector)~=size(vector,2))
    error('Please check the input vectors');
end
vertice=Xcor.minVRep.V;
Hm=Normalize(Xm);
Hcor=Normalize(Xcor);
A_v_Xyk=zeros(size(vector,2),nx);
for i=1:size(vector,2)
    vi=vector(:,i);
    ai=A'*vi;
    [p,~]=Select_vertice(vertice,ai);
    p=p';
    H_p=[];
    for j=1:size(Hcor,1)
        if abs(Hcor(j,1:nx)*p-Hcor(j,nx+1))<10^(-8)
            H_p=[H_p;Hcor(j,:)]; % Select the right facets
        end
    end
    H_p_Xm=[];H_p_Xmy=[];
    for j=1:size(H_p,1)
        flag=0;
        for m=1:size(Hm,1)
            if norm(H_p(j,:)-Hm(m,:),inf)<10^(-8)
                H_p_Xm=[H_p_Xm;H_p(j,1:nx)];
                flag=1;
                break
            end
        end
        if flag==0
            H_p_Xmy=[H_p_Xmy;H_p(j,1:nx)];
        end
    end
    gamma=pinv([H_p_Xm;H_p_Xmy]')*ai;
    r1=size(H_p_Xmy,1);
    if r1==0
        a_v_Xyk=zeros(nx,1);
    else
        mu=gamma((end-r1+1):end);
        a_v_Xyk=H_p_Xmy'*mu;
    end
    A_v_Xyk(i,:)=a_v_Xyk';
end
L=pinv(vector')*A_v_Xyk*pinv(C);
end
    
    
