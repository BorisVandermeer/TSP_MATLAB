
I=imread('map.jpg');   %读入图片
I = rgb2gray(I);     %将图片转为灰度图


a=400; 
b=400; 
l=1;    %网格边长
B = imresize(I,[a/l b/l]);%   将数字矩阵转为规定的大小
J=floor(B/255);     %将障碍物所在矩阵转为0，其余区域为1.也可自己将其改为障碍物为1，可行域为0.


axes('GridLineStyle', '-'); 

set(gca,'ydir','reverse');     %y坐标调换，
set(gca,'xdir','reverse')     %x坐标调换
hold on 
grid on
axis([0,a,0,b]); 
set(gca,'xtick',0:10:a,'ytick',0:10:b); 
set(gca,'xtick',400,'ytick',400) 

%障碍物填充为黑色
for i=1:a/l-1 
for j=1:b/l-1 
if(J(i,j)==0) 
y=[i,i,i+1,i+1]*l; 
x=[j,j+1,j+1,j]*l; 
h=fill(x,y,'k'); 
hold on 
end 
end 
end

