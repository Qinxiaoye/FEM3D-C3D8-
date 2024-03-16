function showResult(dispT,dt,sumTime,ndim,x)
% 应用于瞬态问题，显示指定节点指定自由度的结果曲线

if size(dispT,1)>0
    figure
    hold on
    plot(0:dt:sumTime,x((dispT(:,1)-1)*ndim+dispT(:,2),:),'LineWidth',1);
    xlabel('Time');
    ylabel('Displacement');
    grid on;
    if size(dispT,1)>1
        legend('show');
    end
end