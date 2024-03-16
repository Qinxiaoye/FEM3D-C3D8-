function [J,B] = elemB3D(x,y,z,ks,yt,zita,mnode)
% 返回单元B矩阵
B = zeros(6,3*mnode);
[N_ks,N_yt,N_zita] = dfun3D(ks,yt,zita,mnode);
J = jacobi3D(x,y,z,N_ks,N_yt,N_zita);  % x,y,z,为列向量

for n = 1:mnode
    N_cor = J\[N_ks(n);N_yt(n);N_zita(n)];
    B(1,3*n-2) = N_cor(1);
    B(2,3*n-1) = N_cor(2);
    B(3,3*n)   = N_cor(3);
    B(4,3*n-2) = N_cor(2);
    B(4,3*n-1) = N_cor(1);
    B(5,3*n-1) = N_cor(3);
    B(5,3*n)   = N_cor(2);
    B(6,3*n-2) = N_cor(3);
    B(6,3*n)   = N_cor(1);
end
