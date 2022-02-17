function [dist,mypath,path]=Dijkstra(dg,S,T)
n=length(dg);   %���þ����С
temp=S;         %������ʼ��
m=dg;           %����n�������

inf=1e12;
m(m==0)=inf;

for i=1:n
    m(i,i)=0;
end
pb(1:length(m))=0;pb(temp)=1;   %������·���ĵ�Ϊ1��δ�����Ϊ0
d(1:length(m))=0;               %��Ÿ������̾���
path(1:length(m))=0;            %��Ÿ������·������һ����
while sum(pb)<n                 %�ж�ÿһ���Ƿ����ҵ����·��
 tb=find(pb==0);                %�ҵ���δ�ҵ����·���ĵ�
 fb=find(pb);                   %�ҳ����ҵ����·���ĵ�
 min=inf;
 for i=1:length(fb)
     for j=1:length(tb)
         add=d(fb(i))+m(fb(i),tb(j));  %�Ƚ���ȷ���ĵ���������δȷ����ľ���
         if((d(fb(i))+m(fb(i),tb(j)))<min)
             min=d(fb(i))+m(fb(i),tb(j));
             lastpoint=fb(i);
             newpoint=tb(j);
         end
     end
 end
 d(newpoint)=min;
 pb(newpoint)=1;
 path(newpoint)=lastpoint; %��Сֵʱ����֮���ӵ�
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