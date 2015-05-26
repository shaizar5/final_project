function [f, px, py, mx, my, s] = getInternalParameters()
   f = 50;  % between camera plane and camera center
   s = 0;   % the skew

   % the principle axis is intersecting the camera plane 2 cm up and 2 cm right
   % of the lower left point
   px = f/2;
   py = f/2;

   % the number of pixels per cm:
   mx = 1;
   my = 1;
end

