function plot_map(map)
hold on ; grid on ;
hw = find([map.ways.isHighway]) ;
%bl = find([map.ways.isBuilding]) ;

lines=geo2xy(osmgetlines(map, hw)) ; plot(lines(1,:), lines(2,:), 'b-', 'linewidth', 1.5) ;
%lines=geo2xy(osmgetlines(map, bl)) ; plot(lines(1,:), lines(2,:), 'g-', 'linewidth', 0.75) ;

set(gca,'ydir','reverse') ;
xlabel('Web Mercator X') ;
ylabel('Web Mercator Y') ;
title('OSM in MATLAB') ;
axis equal ; box on ;
end