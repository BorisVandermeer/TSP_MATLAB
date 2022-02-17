function [dist,path_set]=Floyed(dg,sb,db)
inf=66666666;
a = dg;
a(a==0)=inf;
% a—邻接矩阵(aij)是指i 到j 之间的距离，可以是有向的
% sb—起点的标号；
% db—终点的标号
% dist—最短路的距离；
% path_set—最短路的路径
n=size(a,1);% 求a的行数
path=zeros(n);% 生成一个n*n的矩阵

% 遍历path矩阵中的每个元素，而其中的元素path(i,j)表示i到j最短路径上的下个节点的标号
% 初始化 path矩阵 ，将其暂设为 两节点的直接路径的下一节点
for i=1:n
  for j=1:n
    if a(i,j)~=inf  %~=  是  != ,如果i和j之间存在路径
      path(i,j)=j; %j 是i 的后续点
    end
  end
end

% 经过上面对path矩阵的初始化 ， 其变为：
% 若i,j连通，则path(i,j) = j
% 否则path(i,j) = 0 ,即i,j之间不连通

for k=1:n
  for i=1:n
    for j=1:n
      if a(i,j)>a(i,k)+a(k,j)
         a(i,j)=a(i,k)+a(k,j);
          path(i,j)=path(i,k);% 更改 i,j之间最短路径的下一个节点
      end
    end
  end
end
 dist=a(sb,db);
 path_set=sb;
 t=sb;
while t~=db 
% 循环结束的条件是 t 等于 db，这个循环通过迭代来求sb,db的最短路径path_set
  temp=path(t,db);
  path_set=[path_set,temp]; % 将下一个最短路径的节点合并进去 
  t=temp;
end