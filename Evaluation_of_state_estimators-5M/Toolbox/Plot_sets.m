%% Plot these sets
close all
if size(A,1)==2
    disp('Plotting the sets...');
    figure
    p1 = plot(Xm{end},'FaceColor',[1,0,0],'Alpha',0.7,'EdgeColor',[1,0,0]);
    hold on
    for i=1:size(Xp,1)
        p2=plot(Xp{i,end},'LineWidth',1.2,'EdgeColor',[0,0,0],'Alpha',0);
    end
    p3=scatter(x(1,end),x(2,end),'Marker','pentagram','SizeData',300,...
        'MarkerFaceColor',[0,0,0],'MarkerEdgeColor',[0,0,0]);
    y_ran = ylim;
    set(gca,'FontSize',16,'YLim',[y_ran(1),1.2*y_ran(2)-0.2*y_ran(1)]);
    legend([p3,p1,p2],{['$x_{',num2str(k),'}$'], ...
        ['$X_{',num2str(k),'}^{M}$'],...
        ['$X_{',num2str(k),'}^{P}(L_{[0:',num2str(k-1),']})$']},...
        'Interpreter','latex','Location','north'...
        ,'Fontsize',20,'Box','on','Orientation','horizontal'); 
    xlabel('$x(1)$','Interpreter','latex','FontSize',18)
    ylabel('$x(2)$','Interpreter','latex','FontSize',18)
    hold off
    %% The second figure
    figure
    p3 = plot(Xm{end},'color',[1,0,0],'alpha',0.7,'EdgeColor',[1,0,0]);
    hold on
    for i=1:size(Zi,1)
        p4 = plot(Zi{i,end},'alpha',0,'LineWidth',1.2,'EdgeColor',[0,0,0]);
    end
    p5=scatter(x(1,end),x(2,end),'Marker','pentagram','SizeData',300,...
        'MarkerFaceColor',[0,0,0],'MarkerEdgeColor',[0,0,0]);
    y_ran = ylim;
    set(gca,'FontSize',16,'YLim',[y_ran(1),1.2*y_ran(2)-0.2*y_ran(1)]);
    xlabel('$x(1)$','Interpreter','latex','FontSize',18)
    ylabel('$x(2)$','Interpreter','latex','FontSize',18)
    legend([p5,p3,p4],{['$x_{',num2str(k),'}$'], ...
        ['$X_{',num2str(k),'}^{M}$'],...
        ['$X_{',num2str(k),'}^{I}(L_{[0:',num2str(k-1),']},S_{[0:',num2str(k),...
        ']})$']},'Interpreter','latex','Location','north','Fontsize',20,...
        'Box','on','Orientation','Horizontal'); 
end
if size(A,1)==3
    disp('Plotting the sets...');
    figure
    p1 = plot(Xm{end},'FaceColor',[1,0,0],'FaceAlpha',1,'EdgeColor',[1,0,0]);
    hold on
    for i=1:size(Xp,1)
        p2=plot(Xp{i,end},'LineWidth',0.5,'EdgeColor',[0,0,0],'Color',...
            [0,0,0],'EdgeAlpha',0.1,'Alpha',0.01);
    end
    legend([p1,p2],{['$X_{',num2str(k),'}^{M}$'],...
        ['$X_{',num2str(k),'}^{P}(L_{[0:',num2str(k-1),']})$']},...
        'Interpreter','latex','Location','north'...
        ,'Fontsize',22,'Box','off','Orientation','horizontal'); 
    xlabel('$x(1)$','Interpreter','latex')
    ylabel('$x(2)$','Interpreter','latex')
    zlabel('$x(3)$','Interpreter','latex')
    hold off
    %% The second figure
    figure
    p3 = plot(Xm{end},'color',[1,0,0],'alpha',0.7,'EdgeColor',[1,0,0]);
    hold on
    for i=1:size(Zi,1)
        p4 = plot(Zi{i,end},'alpha',0,'LineWidth',1.2,'EdgeColor',[0,0,0]);
    end
    xlabel('$x(1)$','Interpreter','latex')
    ylabel('$x(2)$','Interpreter','latex')
    zlabel('$x(3)$','Interpreter','latex')
    legend([p3,p4],{['$X_{',num2str(k),'}^{M}$'],...
        ['$X_{',num2str(k),'}^{I}(L_{[0:',num2str(k-1),']},S_{[0:',num2str(k),...
        ']})$']},'Interpreter','latex','Location','north','Fontsize',22,...
        'Box','off','Orientation','Horizontal'); 
end
