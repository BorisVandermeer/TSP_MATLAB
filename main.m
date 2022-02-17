%% ���·��
addpath plots                %��ͼ���
addpath GA                   %GA�㷨
addpath SAA                  %SAA�㷨
addpath ACO                  %ACO�㷨
addpath map                  %��ͼ���ݴ���
addpath route_plan           %·�����ݴ���
%add path Raster map          %դ�񻯵�ͼ����

%% ���ݻ�ȡ
fprintf('Getting data from api.map.baidu.com...\n');
center = '�Ͻ��';
[map,image] =  get_data(center);

%��ʾ��ͼ��·��
fprintf('Ploting image and map...\n');
figure(4);
imshow(image);
figure(5)
plot_map(map);


%% ��������
fprintf('loading data...\n');
%map = loadosm('map.osm');
%save('./map/map','map');
%load('map.mat');
%SaveRouteData(map);  
%ֻ��Ҫ����һ�μ��㣬����洢��route_plan\route.mat 
%���ڽڵ����ܶ࣬�����ͩ®�ص�����Ҫ��ܾ�����Ԥ�ȴ洢����
load('route.mat');

%% ��������
Speed = 1; %��û����Ⱥ�ڵ���������н����ٶ�ϵ��
n = 15    ; %���뾭���ڵ������

%% ���˶Խ���ʱ���Ӱ��
KN_1 = [384 269 351]; % �ڵ���,�ֱ��Ӧ����ѧ԰������ѧ¥������ѧ¥
KN_2 = [  8   5   6]; %Ӱ��̶ȣ�1~10��

fprintf('Analsysing the enfluence from Pedestrian...\n');
DG= DGwithPedestrian(dg,KN_1,KN_2);    
   
%���ɼ�����Ҫ���˵���Դͨ������ĳ��·������õ㴦����̾���������·�ϵ��˵��ܶ�
%Ȼ���������ܶ�����������ٶȵ�Ӱ�죬��ӳ��dg������

%% ʹ���㷨���м���
%�洢ÿ���㷨����̾��������ʱ��
CPUtime = Inf(1,3);
Distance = Inf(1,3);
timecost = Inf(1,3);

%�������n���ؾ��ĵط�
 fprintf('Creating random cities  ...\n');
 clear Cities
 [Cities,D,node_index] = create_cities(n,k,dg);

%�ֱ��������������м��㾭���������TSP
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

%�ֱ���Ƴ������㷨�õ���·��
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

%�ֱ���������㷨���Ż�����
%�����������ص�Obj����̫һ��������ͨ��objȥ�Ƚ�������
% figure(1);
% fprintf('Ploting the SAA optimizati...\n');
% plot_track1(Obj_SAA);
% title('SAA�Ż�����');
% 
% figure(2);
% fprintf('Ploting the ACO optimizati...\n');
% plot_track1(Obj_ACO);
% title('ACO�Ż�����');
% 
% figure(3);
% fprintf('Ploting the GA optimizati...\n');
% plot_track1(Obj_GA);
% title('GA�Ż�����');

%�����ַ�ʽ�õ���·�����ʴ�ӡ����
fprintf('================================================\n');
fprintf('         |     SAA    |     ACO    |     GA     \n');
fprintf('---------+------------+------------+------------\n');

    fprintf(' CPUtime |%12f|%12f|%12f\n', CPUtime);
    fprintf('Distance |%12f|%12f|%12f\n',Distance);
    fprintf('TimeCost |%12f|%12f|%12f\n', timecost);

fprintf('================================================\n');
fprintf('\n');

%% �йؾ�����Ĵ洢
Points_SAA = points(node_index(BT_SAA));
Points_ACO = points(node_index(BT_ACO));
Points_GA = points(node_index(BT_GA));