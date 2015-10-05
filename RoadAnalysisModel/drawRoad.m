function drawRoad()
for i=1:size(Constants.FIGURES_3D,2)
    figure(Constants.FIGURES_3D(i));
    roadRight = Constants.ROAD_WIDTH/2;
    roadLeft  = -roadRight;
    roadBottom = 0;
    roadTop = Constants.ROAD_DISTANCE;
    
    x1 = [roadLeft,0,roadBottom;...
          roadRight,0,roadBottom;...
          roadRight,0,roadTop;...
          roadLeft,0,roadTop];

    fill3 (x1(:,1),x1(:,2),x1(:,3),1)
    alpha(0.3)
end
end