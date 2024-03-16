function [GK,force] = boundary_chang_one(GK_u,GK_v,GK_a,fixNode,nodeForce,sumNode,ndim)
% �Խ�Ԫ��1������߽�����
% �������ڸ���λ����0λ��ʱ

fixNodeNew   = (fixNode(:,1)-1)*ndim+fixNode(:,2);
if ~isempty(nodeForce)
    nodeForceNew = (nodeForce(:,1)-1)*ndim+nodeForce(:,2);
else
    nodeForceNew = [];
end

% �γɸն�����غ�����
%sumFix   = size(fixNode,1);
sumForce = size(nodeForceNew,1);

a = (1:sumNode*ndim)';
c = ones(sumNode*ndim,1);
c(fixNodeNew) = 0;
b = sparse(a,a,c,sumNode*ndim,sumNode*ndim);

GK = sparse(GK_u,GK_v,GK_a,sumNode*ndim,sumNode*ndim);
GK = b*GK*b;  % ��ȥfixNodeNew����
GK = GK  -(b-speye(sumNode*ndim));


if size(nodeForce,1) > 0
    force = sparse(nodeForceNew,ones(sumForce,1),nodeForce(:,3),sumNode*ndim,1);%+sparse(bf);
    force = b*force;
else
    force = sparse(sumNode*ndim,1);%+sparse(bf);
    force = b*force;
end

