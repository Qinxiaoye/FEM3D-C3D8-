function [N_ks,N_yt,N_zita] = dfun3D(ks,yt,zita,mnode)
% ���κ����ĵ�������ά
if mnode == 8
    N_ks = zeros(8,1);
    N_yt = zeros(8,1);
    N_zita = zeros(8,1);
    
    N_ks(1) =  (1/8).*((-1)+yt).*((-1)+zita);
    N_ks(2) =  (-1/8).*(1+yt).*((-1)+zita);
    N_ks(3) =  (1/8).*(1+yt).*((-1)+zita);
    N_ks(4) =  (-1/8).*((-1)+yt).*((-1)+zita);
    N_ks(5) =  (-1/8).*((-1)+yt).*(1+zita);
    N_ks(6) =  (1/8).*(1+yt).*(1+zita);
    N_ks(7) =  (-1/8).*(1+yt).*(1+zita);
    N_ks(8) =  (1/8).*((-1)+yt).*(1+zita);


    N_yt(1) =  (1/8).*(1+ks).*((-1)+zita);
    N_yt(2) =  (-1/8).*(1+ks).*((-1)+zita);
    N_yt(3) =  (1/8).*((-1)+ks).*((-1)+zita);
    N_yt(4) =  (-1/8).*((-1)+ks).*((-1)+zita);
    N_yt(5) =  (-1/8).*(1+ks).*(1+zita);
    N_yt(6) =  (1/8).*(1+ks).*(1+zita);
    N_yt(7) =  (-1/8).*((-1)+ks).*(1+zita);
    N_yt(8) =  (1/8).*((-1)+ks).*(1+zita);

    
    N_zita(1) =  (1/8).*(1+ks).*((-1)+yt);
    N_zita(2) =  (-1/8).*(1+ks).*(1+yt);
    N_zita(3) =  (1/8).*((-1)+ks).*(1+yt);
    N_zita(4) =  (-1/8).*((-1)+ks).*((-1)+yt);
    N_zita(5) =  (-1/8).*(1+ks).*((-1)+yt);
    N_zita(6) =  (1/8).*(1+ks).*(1+yt);
    N_zita(7) =  (-1/8).*((-1)+ks).*(1+yt);
    N_zita(8) =  (1/8).*((-1)+ks).*((-1)+yt);


    
end