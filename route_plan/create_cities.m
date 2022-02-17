function [Cities,D,node_index] = create_cities(CityNum,k,dg)
%% МгдиЪ§Он
node_index = randperm(length(k),CityNum);
rand_xy = geo2xy(k(2:3,node_index));
D = zeros(CityNum,CityNum);
for i = 1:CityNum
    for j = 1:CityNum
        D(i,j) = graphshortestpath(dg, node_index(i), node_index(j), 'Directed', true,'Method', 'Dijkstra');      
    end
end
Cities = rand_xy';
end