function plot_track(Obj,BT,Cities,node_index,dg,uids)
%% 绘制迭代曲线
figure(1)
plot(1:size(Obj,1),Obj);
xlabel('迭代次数');
ylabel('距离');
title('优化过程');
%% 绘制
figure(2)
map = loadosm('map.osm');
plot_map(map);
node_set = node_index(BT);
for i = 1:length(node_set)-1
    [~, route] = graphshortestpath(dg, node_set(i), node_set(i+1), 'Directed', true,'Method', 'Dijkstra');
    plot_route(route,map,uids);
end
[~, route] = graphshortestpath(dg, node_set(end), node_set(1), 'Directed', true,'Method', 'Dijkstra');
plot_route(route,map,uids);
plot(Cities(:,1),Cities(:,2),'ro');
end