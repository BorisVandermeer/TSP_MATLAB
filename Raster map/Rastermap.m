
I=imread('map.jpg');   %����ͼƬ
I = rgb2gray(I);     %��ͼƬתΪ�Ҷ�ͼ


a=400; 
b=400; 
l=1;    %����߳�
B = imresize(I,[a/l b/l]);%   �����־���תΪ�涨�Ĵ�С
J=floor(B/255);     %���ϰ������ھ���תΪ0����������Ϊ1.Ҳ���Լ������Ϊ�ϰ���Ϊ1��������Ϊ0.


axes('GridLineStyle', '-'); 

set(gca,'ydir','reverse');     %y���������
set(gca,'xdir','reverse')     %x�������
hold on 
grid on
axis([0,a,0,b]); 
set(gca,'xtick',0:10:a,'ytick',0:10:b); 
set(gca,'xtick',400,'ytick',400) 

%�ϰ������Ϊ��ɫ
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

