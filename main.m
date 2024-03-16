% function  main()
clear;
tic
% read the element and boundary condation 
fprintf(1,'read the modal\n')
node = load('NLIST.DAT');
sumNode = size(node,1);
elem = load('ELIST.DAT');
sumElem = size(elem,1);
fixNode = load('fixNode.dat');
nodeForce = load('nodeForce.dat');
nodeForce(1,:) = [];


mat = [200000,0.3,10;]; % 弹性模量、泊松比、密度
ndim = 3;


reduce = 0;  % 是否采用减缩积分，为1表示就采用（计算结果更精确，但可能会出现零能，沙漏导致计算失败）


matID  = elem(:,2); % 多种材料将用到
EX = mat(matID,1);
mu = mat(matID,2);

elem(:,1:2) = [];
node(:,1)   = [];
node = node(:,1:ndim);

mnode = size(elem,2);  % 单元类型

% ---------------------------转化压强---------------------------------------
if exist('press.dat','file')
    fprintf(1,'trans the pressure\n')
    nodeForceNew = transPres(node,elem);
    nodeForce = [nodeForce;nodeForceNew];
end

% ----------------------------形成总体刚度阵--------------------------------
fprintf(1,'sort the global K\n')

[GK_u,GK_v,GK_a] = globalK3D(EX,mu,elem,node,reduce,mnode);

% ----------------------------边界条件--------------------------------------
fprintf(1,'boundary condition\n')
[GK,force] = boundary_chang_one(GK_u,GK_v,GK_a,fixNode,nodeForce,sumNode,ndim);
% ----------------------------求解方程--------------------------------------
fprintf(1,'solve the equation\n')


u = GK\force;

% ---------------------------转换位移矩阵-----------------------------------
% 将计算所得结果改成非稀疏形式
[nodeNdfID,~,rst] = find(u);
u = zeros(ndim*sumNode,1);
u(nodeNdfID) = rst;
u = reshape(u,ndim,[]);
outputResBina(u,sumNode,sumElem,node,elem,mnode,ndim)
toc


disp('solution is done')