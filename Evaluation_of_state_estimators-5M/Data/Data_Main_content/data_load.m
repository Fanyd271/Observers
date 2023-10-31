T_com_sme=zeros(1,size(T_avg,3));T_com_alg1=zeros(1,size(T_avg,3));
T_com_alg2=zeros(1,size(T_avg,3));Err_alg1=zeros(1,size(T_avg,3));
Err_alg2=zeros(1,size(T_avg,3));Facets=zeros(1,size(T_avg,3));
Vertices=zeros(1,size(T_avg,3));
for i=1:size(T_avg,3)
    T_com_sme(i)=mean(T_avg(1,:,i));
    T_com_alg1(i)=mean(T_avg(2,:,i));
    T_com_alg2(i)=mean(T_avg(3,:,i));
    Err_alg1(i) = mean(Err(1,:,i));
    Err_alg2(i) = mean(Err(2,:,i));
    Facets(i) = mean(Facets_num(1,:,i));
    Vertices(i) = mean(Vertexs_num(1,:,i));
end
close all
%% The average computational time
k_index=10:1:30;
figure
l1=scatter(k_index,T_com_sme,'Marker','diamond','MarkerFaceColor',[0.00,0.45,0.74]);
hold on
l2=scatter(k_index,T_com_alg1,'Marker','o','MarkerFaceColor',[0.85,0.33,0.10]);
l3=scatter(k_index,T_com_alg2,'Marker','^','MarkerFaceColor',[0.93,0.69,0.13]);
p1=polyfit(k_index,T_com_sme,1);p2=polyfit(k_index,T_com_alg1,1);
p3=polyfit(k_index,T_com_alg2,1);
y1 = polyval(p1,k_index);y2 = polyval(p2,k_index);y3 = polyval(p3,k_index);
plot(k_index,y1,'Color',[0.00,0.45,0.74],'Linewidth',1);
plot(k_index,y2,'Color',[0.85,0.33,0.10],'Linewidth',1);
plot(k_index,y3,'Color',[0.93,0.69,0.13],'Linewidth',1);
set(gca,'Fontsize',16);
xlabel('Time step $k$','Interpreter','latex','Fontsize',18);
ylabel('$\overline{\mathbf{t}}_{com}$ ($s$)','Interpreter',...
    'latex','Fontsize',18);
legend([l1,l2,l3],{'SME','Alg-1','Alg-2'},'Interpreter','latex','Fontsize',16)
ylim([0,0.9]);
%% The average errors
figure
plot(k_index,log10(Err_alg1),'Linewidth',1.5,'Marker','+','Color',[0.85,0.33,0.10]);
hold on
plot(k_index,log10(Err_alg2),'Linewidth',1.5,'Marker','o','Color',[0.93,0.69,0.13]);
set(gca,'Fontsize',16);
xlabel('Time step $k$','Interpreter','latex','Fontsize',18);
ylabel('$\log_{10}(\overline{\mathbf{e}}_r)$ ','Interpreter',...
    'latex','Fontsize',18);
legend({'Alg-1','Alg-2'},'Interpreter','latex','Fontsize',16)
%% The facets number
figure
plot(k_index,Facets,'Linewidth',1.5,'Marker','o','Color',[1,0,0]);
set(gca,'Fontsize',16);
xlabel('Time step $k$','Interpreter','latex','Fontsize',18);
ylabel('Average facets number ','Interpreter',...
    'latex','Fontsize',18);
%% The vertices number
figure
plot(k_index,Vertices,'Linewidth',1.5,'Marker','o','Color',[0,0,1]);
set(gca,'Fontsize',16);
xlabel('Time step $k$','Interpreter','latex','Fontsize',18);
ylabel('Average vertices number ','Interpreter',...
    'latex','Fontsize',18);