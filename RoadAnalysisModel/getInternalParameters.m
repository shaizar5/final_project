function [f, px, py, mx, my, s] = getInternalParameters()
   f = 50;  % between camera plane and camera center
   s = 0;   % the skew

   % the principle axis is intersecting the camera 
   % of the lower left point
   px = 0;
   py = 0;

   % the number of pixels per cm:
   mx = 1;
   my = 1;
end

