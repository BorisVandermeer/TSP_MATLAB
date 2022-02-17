function plot_nodes(latitude,longitude)
hold on
xy = geo2xy([latitude;longitude]);
plot(xy(1,:),xy(2,:),'pr');
end