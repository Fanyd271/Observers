%%
close all
plot(log10(Error_1),'Linewidth',1.5,'Marker','o');
set(gca,'Fontsize',16);
set(gcf,'Position',[231.4,294.6,769.6,420]);
xticks(1:length(Error_3))
xlabel('Facet number','Interpreter','latex','Fontsize',18);
ylabel('$\log_{10}(\mathbf{e}_r)$ ','Interpreter',...
    'latex','Fontsize',18);
%%
figure
plot(log10(Error_3),'Linewidth',1.5,'Marker','o');
set(gca,'Fontsize',16);
set(gcf,'Position',[231.4,294.6,769.6,420]);
xticks(1:length(Error_3))
xlabel('Facet number','Interpreter','latex','Fontsize',18);
ylabel('$\log_{10}(|d_i^M-d_i|)$ ','Interpreter',...
    'latex','Fontsize',18);
