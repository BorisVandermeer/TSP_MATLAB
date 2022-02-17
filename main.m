%% 添加路径
addpath plots                %绘图相关
addpath GA                   %GA算法
addpath SAA                  %SAA算法
addpath ACO                  %ACO算法
addpath map                  %地图数据处理
addpath route_plan           %路线数据处理
%add path Raster map          %栅格化地图数据

%% 数据获取
fprintf('Getting data from api.map.baidu.com...\n');
center = '紫金港';
[map,image] =  get_data(center);

%显示地图和路网
fprintf('Ploting image and map...\n');
figure(4);
imshow(image);
figure(5)
plot_map(map);


%% 导入数据
fprintf('loading data...\n');
%map = loadosm('map.osm');
%save('./map/map','map');
%load('map.mat');
%SaveRouteData(map);  
%只需要进行一次计算，结果存储在route_plan\route.mat 
%由于节点数很多，相较于桐庐县的样例要算很久所以预先存储下来
load('route.mat');

%% 常数定义
Speed = 1; %在没有人群遮挡的情况下行进的速度系数
n = 15    ; %必须经过节点的数量

%% 行人对进行时间的影响
KN_1 = [384 269 351]; % 节点编号,分别对应三个学园、西教学楼、东教学楼
KN_2 = [  8   5   6]; %影响程度（1~10）

fprintf('Analsysing the enfluence from Pedestrian...\n');
DG= DGwithPedestrian(dg,KN_1,KN_2);    
   
%生成几个主要的人的来源通过计算某条路两端与该点处的最短距离来体现路上的人的密度
%然后根据这个密度算出对行走速度的影响，反映到dg矩阵上

%% 使用算法进行计算
%存储每个算法的最短距离和运行时间
CPUtime = Inf(1,3);
Distance = Inf(1,3);
timecost = Inf(1,3);

%随机生成n个必经的地方
 fprintf('Creating random cities  ...\n');
 clear Cities
 [Cities,D,node_index] = create_cities(n,k,dg);

%分别用三个方法进行计算经过这随机的TSP
 tic;
 fprintf('Working on the map using Algorithm SAA ...\n');
 [Obj_SAA,BT_SAA] = TSP_SAA(Cities,D);
 CPUtime(1) = toc;
 Distance(1) = GetRouteDistance(dg,BT_SAA);
 timecost(1) = GetRouteDistance(DG,BT_SAA)/Speed*90;
 
 tic;
 fprintf('Working on the map using Algorithm ACO ...\n');
 [Obj_ACO,BT_ACO] = TSP_ACO(Cities,D);
 CPUtime(2) = toc;
 Distance(2) = GetRouteDistance(dg,BT_ACO);
 timecost(2) = GetRouteDistance(DG,BT_ACO)/Speed*90;
 
 tic;
  fprintf('Working on the map using Algorithm GA ...\n');
 [Obj_GA,BT_GA] = TSP_GA(Cities,D);
 CPUtime(3) = toc;
 Distance(3) = GetRouteDistance(dg,BT_GA);
 timecost(3) = GetRouteDistance(DG,BT_GA)/Speed*90;

%分别绘制出三种算法得到的路径
figure(1);
fprintf('Ploting the SAA route...\n');
plot_track2(BT_SAA,Cities,node_index,dg,uids);
title('SAA');

figure(2);
fprintf('Ploting the ACO route...\n');
plot_track2(BT_ACO,Cities,node_index,dg,uids);
title('ACO');

figure(3);
fprintf('Ploting the GA route...\n');
plot_track2(BT_GA,Cities,node_index,dg,uids);
title('GA');

%分别绘制三种算法的优化过程
%三个函数返回的Obj意义太一样，很难通过obj去比较其优劣
% figure(1);
% fprintf('Ploting the SAA optimizati...\n');
% plot_track1(Obj_SAA);
% title('SAA优化过程');
% 
% figure(2);
% fprintf('Ploting the ACO optimizati...\n');
% plot_track1(Obj_ACO);
% title('ACO优化过程');
% 
% figure(3);
% fprintf('Ploting the GA optimizati...\n');
% plot_track1(Obj_GA);
% title('GA优化过程');

%将三种方式得到的路径性质打印出来
fprintf('================================================\n');
fprintf('         |     SAA    |     ACO    |     GA     \n');
fprintf('---------+------------+------------+------------\n');

    fprintf(' CPUtime |%12f|%12f|%12f\n', CPUtime);
    fprintf('Distance |%12f|%12f|%12f\n',Distance);
    fprintf('TimeCost |%12f|%12f|%12f\n', timecost);

fprintf('================================================\n');
fprintf('\n');

%% 有关经过点的存储
Points_SAA = points(node_index(BT_SAA));
Points_ACO = points(node_index(BT_ACO));
Points_GA = points(node_index(BT_GA));