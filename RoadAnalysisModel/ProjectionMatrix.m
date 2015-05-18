function P = ProjectionMatrix(R, Ct, f, px, py, mx, my, s )
% calculates the projection matrix given the internal and external 
% camera parameters 
% 
% input: 
% R 3x3 rotation matrix 
% Ct 3x1 camera center in world coordinates 
% f,px,py,mx,my,s scalars, the internal camera parameters 
% 
% output: 
% P                 3x4 projection matrix, normalized so its 
%                   last element is 1

x0 = mx*px;
y0 = my*py;
alphaX = f*mx;
alphaY = f*my;
K = [alphaX, s, x0;...
    0, alphaY, y0; ...
    0,0,1];
KRC = (K*R*Ct).*(-1);

P = [K*R , KRC];
P = P./P(3,4);
end

