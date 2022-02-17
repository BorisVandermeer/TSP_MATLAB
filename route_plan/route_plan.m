function [dist, route] = route_plan(S,T,map)
%% 数据集
nodes = {map.nodes.id};
nodes = horzcat(nodes{:});

lats = {map.nodes.lat};
lats = horzcat(lats{:});

lons = {map.nodes.lon};
lons = horzcat(lons{:});

%% 获取节点
hw = [map.ways.isHighway];
ids = {map.ways(hw).nds}; 
ids = horzcat(ids{:});
ids = double(ids);
[h,c] = hist(ids,unique(ids));
uids = c(h>1);

%%
k = zeros(3,length(uids));
for i=1:length(uids)
    k(1,i) = find(nodes(:)==uids(i));
    k(2,i) = lats(k(1,i));
    k(3,i) = lons(k(1,i));
end
points = geo2xy(k(2:3,:));
% hold on;
% plot_map(map);
% for i = 1:length(uids)
%     text(points(1,i),points(2,i),num2str(i),'color','r');
% end
%%
dg = sparse([]);
for i = 1:length(uids)
    for j = 1:length(uids)
        for way_index = 1:length(map.ways)
            wS = find(map.ways(way_index).nds == uids(i),1);
            wT = find(map.ways(way_index).nds == uids(j),1);
            if ~isempty(wS) && ~isempty(wT)
                a = min(wS,wT);
                b = max(wS,wT);
                x = map.ways(way_index).points(1,a:b);
                y = map.ways(way_index).points(2,a:b);
                pd = geo2xy([x;y]);
                dx = diff(pd(1,:));
                dy = diff(pd(2,:));
                d = sum(sqrt(dx.^2+dy.^2));   
                dg(i,j) = d;
                dg(j,i) = d;
            end
        end
    end
end
save('./route_plan/route','dg','k','points','uids');
%% 
[dist, route] = graphshortestpath(dg, S, T, 'Directed', true,'Method', 'Dijkstra');
plot_route(route,map,uids);
end
