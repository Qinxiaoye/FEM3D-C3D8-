function [u,v,a] = globalK3D(elemEX,elemMu,elem,node,reduce,mnode)
% 生成总体刚度矩阵
% 适用于四节点四边形单元
% 总体刚度阵GK采用行-列-值(u-v-a)的稀疏矩阵形式存储
% sumNode = size(node,1);
sumElem = size(elem,1);

u = zeros(sumElem*(mnode*3)*(mnode*3),1); % 系数矩阵的行-列-值
v = zeros(sumElem*(mnode*3)*(mnode*3),1);
a = zeros(sumElem*(mnode*3)*(mnode*3),1);


% GK = zeros(sumNode*2);
if mnode == 8
    x = zeros(8,1);
    y = zeros(8,1);
    z = zeros(8,1);
    for n = 1:sumElem
        EX = elemEX(n);
        mu = elemMu(n);
        for m = 1:8
            x(m) = node(elem(n,m),1);
            y(m) = node(elem(n,m),2);
            z(m) = node(elem(n,m),3);
        end
        K = elemK3D(EX,mu,x,y,z,reduce,mnode);  % 生成单元刚度阵
        nodeID = elem(n,:);
        ndfID([1,4,7,10,13,16,19,22]) = nodeID*3-2;
        ndfID([2,5,8,11,14,17,20,23]) = nodeID*3-1;
        ndfID([3,6,9,12,15,18,21,24]) = nodeID*3;
        ddd = repmat(ndfID,24,1); % ddd 为临时变量，无实际意义
        u(576*(n-1)+1:576*n) = ddd(:);
        v(576*(n-1)+1:576*n) = repmat(ndfID,1,24);
        a(576*(n-1)+1:576*n) = K(:);
    end
end











