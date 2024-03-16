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


mat = [200000,0.3,10;]; % ����ģ�������ɱȡ��ܶ�
ndim = 3;


reduce = 0;  % �Ƿ���ü������֣�Ϊ1��ʾ�Ͳ��ã�����������ȷ�������ܻ�������ܣ�ɳ©���¼���ʧ�ܣ�


matID  = elem(:,2); % ���ֲ��Ͻ��õ�
EX = mat(matID,1);
mu = mat(matID,2);

elem(:,1:2) = [];
node(:,1)   = [];
node = node(:,1:ndim);

mnode = size(elem,2);  % ��Ԫ����

% ---------------------------ת��ѹǿ---------------------------------------
if exist('press.dat','file')
    fprintf(1,'trans the pressure\n')
    nodeForceNew = transPres(node,elem);
    nodeForce = [nodeForce;nodeForceNew];
end

% ----------------------------�γ�����ն���--------------------------------
fprintf(1,'sort the global K\n')

[GK_u,GK_v,GK_a] = globalK3D(EX,mu,elem,node,reduce,mnode);

% ----------------------------�߽�����--------------------------------------
fprintf(1,'boundary condition\n')
[GK,force] = boundary_chang_one(GK_u,GK_v,GK_a,fixNode,nodeForce,sumNode,ndim);
% ----------------------------��ⷽ��--------------------------------------
fprintf(1,'solve the equation\n')


u = GK\force;

% ---------------------------ת��λ�ƾ���-----------------------------------
% ���������ý���ĳɷ�ϡ����ʽ
[nodeNdfID,~,rst] = find(u);
u = zeros(ndim*sumNode,1);
u(nodeNdfID) = rst;
u = reshape(u,ndim,[]);
outputResBina(u,sumNode,sumElem,node,elem,mnode,ndim)
toc


disp('solution is done')