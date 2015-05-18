%Shai Zarzewski 300300340 & Noam Mizrachi 300777646
function [K, R, C] = DecomposeProjectionMatrix(P) 
% given a projection matrix P, finds its center of projection, its 
% rotation matrix and its inner parameters matrix 
% input: 
% P 3x4 a projection matrix 
% output: 
% K 3x3 an upper triangular matrix of inner camera 
% parameters:
% R 3x3 the camera rotation matrix 
% C 3x1 the camera center of projection

nP = null(P) 
Ch = zeros(3,1);
if (nP(4)~=0)
    Ch = nP ./nP(4);
end
C = Ch(1:3);

M = [P(:,1) P(:,2) P(:,3)];
[Q, L] = qr(inv(M));
K = inv(L);
R = inv(Q);

K = K/K(3,3);

%making sure that the elements on K's diagonal are positive
if (K(1,1)<0)
    K(1,1) = K(1,1)*-1;
    R(1,1:3) = R(1,1:3) * -1;
end

if (K(2,2)<0)
    K(2,2) = K(2,2)*-1;
    R(2,1:3) = R(2,1:3) * -1;
    K(1,2)=K(1,2) * -1;
end

end
