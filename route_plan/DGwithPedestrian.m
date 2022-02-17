function DG = DGwithPedestrian(dg,KN1,KN2)
%DGWITHPEDESTRIAN 将原来的稀疏矩阵添加上行人对路线需要时间的影响
A = full(dg);
s = size(A,1);
B = zeros(s,s);
for i = 1:s
    for j = 1:s
        if(A(i,j)~=0)
            B(i,j) = A(i,j) * (enfluence(dg,i,KN1,KN2)+enfluence(dg,j,KN1,KN2));
        end
    end
DG =  sparse(B);
end
end

function P = enfluence(dg,a,kn1,kn2)
    %计算节点A处的密度来源对其的影响
    sk = size(kn1);
    dist = zeros(sk);
    for i = 1:sk
        [m,~] = graphshortestpath(dg,kn1(i), a, 'Directed', true,'Method', 'Dijkstra');
        dist(i) = 0.001/(m+0.001)*kn2(i);
    end
    P = sum(dist);
end