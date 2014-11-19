function plot_image(filename,y_coords,x_coords,plot_title,x_label,y_label)
if nargin < 3 
    x_coords = 1:max(size(y_coords))
    plot_title='error graph';
    x_label = 'epoch';
    y_label = 'error rate';
end
if nargin<4
    plot_title='error graph';
    x_label = 'epoch';
    y_label = 'error rate';
    
end

fig_handle=figure; plot(x_coords,y_coords,'--ro');
set(gca,'FontName','Arial','FontSize',14);
title(plot_title,'fontsize',12,'fontname','arial');
xlabel(x_label,'fontsize',17,'fontname','arial');
ylabel(y_label,'fontsize',17,'fontname','arial');
% ylabel('Temps. [¡ÆC]','fontsize',17,'fontname','arial')
fpath = 'tmp\'
filepath = strcat(fpath,filename);
saveas(fig_handle,filepath) ;