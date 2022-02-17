function plot_track1(Obj)
%% 绘制迭代曲线
plot(1:size(Obj,1),Obj);
xlabel('迭代次数');
ylabel('距离');
end