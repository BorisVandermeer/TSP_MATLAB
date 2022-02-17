function [way_index,way_id] = find_road(node_ID1,node_ID2,map)
    way_id = 0;
    way_index = 0;
    for curry_way = 1:length(map.ways)
        a = find(node_ID1 == map.ways(curry_way).nds,1);
        b = find(node_ID2 == map.ways(curry_way).nds,1);
        if ~isempty(a) && ~isempty(b)
            way_id = map.ways(curry_way).id;
            way_index = curry_way;
        end
    end
end
