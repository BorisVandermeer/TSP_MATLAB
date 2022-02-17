function [Obj,BT]=TSP_SAA(Cities,D)
%% ģ���˻������ʼ�� 
T0 =500;            %��ʼ�¶�
Tend = 1e-4;        %��ֹ�¶�
L = 200;            %�����¶��µ�����
q = 0.98;           %��������
N = size(Cities,1);
S1 = randperm(N);   %����һ�������
Time = round(log(Tend/T0)/log(q));
count = 0; %����������
Obj = zeros(Time,1);    %ÿ��·����
track = zeros(Time,N);  %ÿ�����Ž�
%% ����
while T0>Tend
    count = count + 1;
    temp = zeros(L,N+1);
    for kl = 1:L
        %����L���½�
        S2 = newSolution(S1);
        [S1,R] = Metropolis(S1,S2,D,T0);
        temp(kl,:)=[S1 R];
    end
    %��¼ÿ�ε������̵�����·��
    [d0,index] = min(temp(:,end));
    if count == 1 || d0 <Obj(count-1)
        Obj(count) = d0;
    else
        Obj(count)=Obj(count - 1);
    end
     
    track(count,:)=temp(index,1:end-1);
    T0 = q*T0;
end
% fprintf('����������%d\n',count);
% fprintf('���·����%f\n',Obj(end));
%% ���ɵ�������
 BT = track(end,:);
% figure(1)
% plot(1:count,Obj);
% xlabel('��������');
% ylabel('����');
% title('�Ż�����');

end
 
%% newSolution
%�������ܣ������½�
%���룺�ɽ� ������½�
%���ѡ����λ�ý�����
function S2 = newSolution(S1)
    N = length(S1);
    S2 = S1;
    a = round( rand(1,2)*(N-1)+1);  %�����������λ����������
    temp = S2(a(1));
    S2(a(1))=S2(a(2));
    S2(a(2)) = temp;
end

%% Metropolis
%Metropolis׼����
%���룺�½⣬�ɽ⣬������󣬵�ǰ�¶�
%������жϺ�Ľ⣬���·��
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
%����·�߳��ȵĺ���
%���룺����������ߵ�˳��  �����·����
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