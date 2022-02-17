function map = get_osm(latitude,longitude)
longitude = num2str(longitude);
latitude  = num2str(latitude);
command = ['python ./spider.py ', '16', ' ' , longitude , ' ',latitude];
system(command);
map = loadosm('map.osm') ;
end