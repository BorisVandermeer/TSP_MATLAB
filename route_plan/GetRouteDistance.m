function d = GetRouteDistance(dg,route)
%用于计算在dg矩阵情况下route的总长度
dist = zeros(1,length(route));
for i = 1:length(route)-1
    [dist(i),~] = graphshortestpath(dg, route(i), route(i+1), 'Directed', true,'Method', 'Dijkstra');
end
    dist(length(route)) = graphshortestpath(dg, route(length(route)), route(1),...
                                            'Directed', true,'Method', 'Dijkstra');
    d = sum(dist);
end

