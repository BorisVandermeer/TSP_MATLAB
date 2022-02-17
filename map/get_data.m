function [map,image] =  get_data(center)
%% 使用百度地图API获得地图
API = 'http://api.map.baidu.com/staticimage/v2';
ak = 'DhysQ5QKPqG87W7wxBv23UI8lriYq0PU';
width = 1024;
height = 1024;
zoom = 16;
copyright = 0;
dpiType = 'ph';
[a,b,~]= webread(API,'ak',ak,'width',width,'height',height,'center',...
center,'zoom',zoom,'copyType',copyright,'dpiType',dpiType);
image = ind2rgb(a,b);
%imshow(image);
%% 获得经纬度
APIv3 = 'http://api.map.baidu.com/geocoding/v3';
address = center;
output='xml';
result = webread(APIv3,'address',address,'ak',ak,'output',output);

get_lat='<lat>.*?</lat>';
get_lng='<lng>.*?</lng>';

latitude  = xml2num(result,get_lat,1);
longitude = xml2num(result,get_lng,1);

%% 获取路网信息
% https://www.openstreetmap.org/export#map=16/30.3049/120.0876
latitude  = 30.3049;
longitude = 120.0876;
map = get_osm(latitude,longitude);
end

