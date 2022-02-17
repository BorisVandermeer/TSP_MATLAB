function [Obj,BT] = TSP_GA(Cities,D)
%tStart = tic; % �㷨��ʱ��

cities=Cities';
cityNum = size(cities,2);

maxGEN = 1000;
popSize = 100; % �Ŵ��㷨��Ⱥ��С
crossoverProbabilty = 0.9; %�������
mutationProbabilty = 0.5; %�������
 
gbest = Inf;

distances = D;
 
% ������Ⱥ��ÿ���������һ��·��
pop = zeros(popSize, cityNum);
for i=1:popSize
    begin=[1]; %����ȡ���
    
    poptemp=2:cityNum;%��ȥ���������
    
    randIndex_poptemp = randperm(cityNum-1);
    poptemp = poptemp(randIndex_poptemp);%��poptemp�������

    pop(i,:) = [begin poptemp]; 
    
   % pop(i,:) = randperm(cityNum); 
end
offspring = zeros(popSize,cityNum);
%����ÿ������С·�����ڻ�ͼ
minPathes = zeros(maxGEN,1);
 
% GA�㷨
for  gen=1:maxGEN
 
    % ������Ӧ�ȵ�ֵ����·���ܾ���
    [fval, sumDistance, minPath, maxPath] = fitness(distances, pop);
 
    % ���̶�ѡ��
    tournamentSize=4; %���ô�С
    for k=1:popSize
        % ѡ�񸸴����н���
        tourPopDistances=zeros( tournamentSize,1);
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
 
        % ѡ����õģ���������С��
        parent1  = min(tourPopDistances);
        [parent1X,parent1Y] = find(sumDistance==parent1,1, 'first');
        parent1Path = pop(parent1X(1,1),:);
        parent1Path = parent1Path([2:length(parent1Path)]);
 
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
        parent2  = min(tourPopDistances);
        [parent2X,parent2Y] = find(sumDistance==parent2,1, 'first');
        parent2Path = pop(parent2X(1,1),:);
        parent2Path = parent2Path([2:length(parent2Path)]);
 
        subPath = crossover(parent1Path, parent2Path, crossoverProbabilty);%����
        subPath = mutate(subPath, mutationProbabilty);%����
        subPath = [begin subPath];
 
        offspring(k,:) = subPath(1,:);
        
        minPathes(gen,1) = minPath; 
    end
%     fprintf('����:%d   ���·��:%.5f \n', gen, minPath);
    % ����
    pop = offspring;
    % ������ǰ״̬�µ����·��
    if minPath < gbest
        BT = pop(end,:);
        gbest = minPath;
%         paint(cities, pop, gbest, sumDistance,gen);
    end
end
Obj = minPathes;
% figure 
% plot(minPathes, 'MarkerFaceColor', 'red','LineWidth',1);
% Obj = minPathes;
% title('��������ͼ��ÿһ�������·����');
% set(gca,'ytick',500:100:5000); 
% ylabel('·������');
% xlabel('��������');
% grid on
% tEnd = toc(tStart);
% fprintf('ʱ��:%d ��  %f ��.\n', floor(tEnd/60), rem(tEnd,60));
end