function J = jacobi3D(x,y,z,N_ks,N_yt,N_zita)
% ��jacobi ����
% ��ά�����嵥Ԫ

J = [N_ks,N_yt,N_zita]'*[x,y,z];