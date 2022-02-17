function [Obj,BT]=TSP_SAA(Cities,D)
%% 模拟退火参数初始化 
T0 =500;            %初始温度
Tend = 1e-4;        %终止温度
L = 200;            %各个温度下的链长
q = 0.98;           %降温速率
N = size(Cities,1);
S1 = randperm(N);   %产生一个随机解
Time = round(log(Tend/T0)/log(q));
count = 0; %迭代计数器
Obj = zeros(Time,1);    %每代路径和
track = zeros(Time,N);  %每代最优解
%% 迭代
while T0>Tend
    count = count + 1;
    temp = zeros(L,N+1);
    for kl = 1:L
        %产生L组新解
        S2 = newSolution(S1);
        [S1,R] = Metropolis(S1,S2,D,T0);
        temp(kl,:)=[S1 R];
    end
    %记录每次迭代过程的最优路线
    [d0,index] = min(temp(:,end));
    if count == 1 || d0 <Obj(count-1)
        Obj(count) = d0;
    else
        Obj(count)=Obj(count - 1);
    end
     
    track(count,:)=temp(index,1:end-1);
    T0 = q*T0;
end
% fprintf('迭代次数：%d\n',count);
% fprintf('最短路径：%f\n',Obj(end));
%% 生成迭代曲线
 BT = track(end,:);
% figure(1)
% plot(1:count,Obj);
% xlabel('迭代次数');
% ylabel('距离');
% title('优化过程');

end
 
%% newSolution
%函数功能：生成新解
%输入：旧解 输出：新解
%随机选两个位置交换。
function S2 = newSolution(S1)
    N = length(S1);
    S2 = S1;
    a = round( rand(1,2)*(N-1)+1);  %产生两个随机位置用来交换
    temp = S2(a(1));
    S2(a(1))=S2(a(2));
    S2(a(2)) = temp;
end

%% Metropolis
%Metropolis准则函数
%输入：新解，旧解，距离矩阵，当前温度
%输出：判断后的解，解的路径
function [S,R] = Metropolis(S1,S2,D,T)
    R1 = pathLength(D,S1);
    R2 = pathLength(D,S2);
    dT = R2 - R1;
    if dT < 0
       S=S2;
       R=R2;
    elseif exp(-dT/T) >= rand
       S=S2;
       R=R2;
    else
       S=S1;
       R=R1;
    end
end
 
%% pathLength
%计算路线长度的函数
%输入：距离矩阵，行走的顺序  输出：路径和
function len = pathLength(D,S)
    [~,c] = size(D);
    NIND = size(S,1);
    for i = 1:NIND
        p = [S(i,:) S(i,1)];
        i1 = p(1:end-1);
        i2 = p(2:end);
        len(i,1) = sum(D((i1-1)*c + i2));
    end
end