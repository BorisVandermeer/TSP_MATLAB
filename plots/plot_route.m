function plot_route(route,map,uids)
   for i = 1:length(route)-1
       way_index =  find_road(uids(route(i)),uids(route(i+1)),map);
       a = find(uids(route(i)) == map.ways(way_index).nds,1);
       b = find(uids(route(i+1)) == map.ways(way_index).nds,1);
       S = min(a,b);
       T = max(a,b);
       x = map.ways(way_index).points(1,S:T);
       y = map.ways(way_index).points(2,S:T);
       xy = geo2xy([x;y]);
       plot(xy(1,:), xy(2,:), 'g-','linewidth', 2) ;
   end
end