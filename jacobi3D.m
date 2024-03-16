function J = jacobi3D(x,y,z,N_ks,N_yt,N_zita)
% 求jacobi 矩阵
% 三维六面体单元

J = [N_ks,N_yt,N_zita]'*[x,y,z];