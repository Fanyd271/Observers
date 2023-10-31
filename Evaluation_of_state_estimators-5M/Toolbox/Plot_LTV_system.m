close all
%% Single threading for computing X_{k+1}^P
Ns = size(L_svo,1);
Xp = cell(Ns,k);
for i=1:Ns % SVO
    Xp{i,1}=X0;
    for j=1:k
        Xp{i,j+1}=mRep(mRep((A{j}-L_svo{i,j}*C)*Xp{i,j})+B*u(:,j)+...
            mRep(E{j}*W+L_svo{i,j}*Y{j}));
    end
end
%% Compute the intervals X_{k+1}^I
Ni = size(L_io,1); % Number of required IOs
Zi=cell(Ni,k);
for i=1:Ni % SVO
    Zi{i,1}=Box(S{i,1}*X0);
    for j=1:k
        Zi{i,j+1}=Box(mRep(S{i,j+1}*(A{j}-L_io{i,j}*C)*S{i,j}^(-1)*Zi{i,j})+...
        S{i,j+1}*B*u(:,j)+mRep(S{i,j+1}*L_io{i,j}*Y{j})+mRep(S{i,j+1}*E{j}*W)); 
    end
end
%% Plot these sets
if size(A{1},1)==2
    disp('Plotting the sets...');
    figure
    p1 = plot(Xm{end},'FaceColor',[1,0,0],'FaceAlpha',1,'EdgeColor',[1,0,0]);
    hold on
    for i=1:size(Xp,1)
        p2=plot(Xp{i,end},'LineWidth',1.2,'EdgeColor',[0,0,0],'Alpha',0);
    end
    y_ran = ylim;
    set(gca,'FontSize',16,'YLim',[y_ran(1),1.2*y_ran(2)-0.2*y_ran(1)]);
    legend([p1,p2],{['$X_{',num2str(k),'}^{M}$'],...
        ['$X_{',num2str(k),'}^{P}(L_{[0:',num2str(k-1),']})$']},...
        'Interpreter','latex','Location','north'...
        ,'Fontsize',20,'Box','on','Orientation','horizontal'); 
    xlabel('$x(1)$','Interpreter','latex')
    ylabel('$x(2)$','Interpreter','latex')
    hold off
    %% The second figure
    figure
    p3 = plot(Xm{end},'color',[1,0,0],'alpha',1,'EdgeColor',[1,0,0]);
    hold on
    for i=1:size(Zi,1)
        p4 = plot(Zi{i,end},'alpha',0,'LineWidth',1.2,'EdgeColor',[0,0,0]);
    end
    y_ran = ylim;
    set(gca,'FontSize',16,'YLim',[y_ran(1),1.2*y_ran(2)-0.2*y_ran(1)]);
    xlabel('$x(1)$','Interpreter','latex')
    ylabel('$x(2)$','Interpreter','latex')
    legend([p3,p4],{['$X_{',num2str(k),'}^{M}$'],...
        ['$X_{',num2str(k),'}^{I}(L_{[0:',num2str(k-1),']},S_{[0:',num2str(k),...
        ']})$']},'Interpreter','latex','Location','north','Fontsize',20,...
        'Box','on','Orientation','Horizontal'); 
end