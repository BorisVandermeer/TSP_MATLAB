function [dist,mypath,path]=Dijkstra(dg,S,T)
n=length(dg);   %设置矩阵大小
temp=S;         %设置起始点
m=dg;           %定义n阶零矩阵

inf=1e12;
m(m==0)=inf;

for i=1:n
    m(i,i)=0;
end
pb(1:length(m))=0;pb(temp)=1;   %求出最短路径的点为1，未求出的为0
d(1:length(m))=0;               %存放各点的最短距离
path(1:length(m))=0;            %存放各点最短路径的上一点标号
while sum(pb)<n                 %判断每一点是否都已找到最短路径
 tb=find(pb==0);                %找到还未找到最短路径的点
 fb=find(pb);                   %找出已找到最短路径的点
 min=inf;
 for i=1:length(fb)
     for j=1:length(tb)
         add=d(fb(i))+m(fb(i),tb(j));  %比较已确定的点与其相邻未确定点的距离
         if((d(fb(i))+m(fb(i),tb(j)))<min)
             min=d(fb(i))+m(fb(i),tb(j));
             lastpoint=fb(i);
             newpoint=tb(j);
         end
     end
 end
 d(newpoint)=min;
 pb(newpoint)=1;
 path(newpoint)=lastpoint; %最小值时的与之连接点
end

 dist=d(T);
 i=1;
 while T~=S
    mypath(i)=T;
    T=path(T);
    i=i+1;
 end
mypath(i)=S;

mypath=fliplr(mypath);