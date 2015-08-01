function walkingCane(ct,step)
  if (~Constants.SHOW_WALKING_CANE)
      return
  end
  walkingCaneHand = 1;
  if (~Constants.WALKING_CANE_ON_RIGHT_HAND)
     walkingCaneHand = -1;
  end
  
  caneStartPos = ct+[walkingCaneHand*Constants.CANE_DISTANCE_FROM_BODY_CENTER,0,0]';
  caneEndPos = [Constants.CANE_MOVEMENT*step,0,Constants.CANE_END_POINT_DISTANCE*step]';
  caneRadius = Constants.CANE_RADIUS;
  caneDensity = Constants.CANE_DENSITY;
  [Cylinder, EndPlate1, EndPlate2] = Cylinder3D(caneStartPos,caneEndPos,caneRadius,caneDensity,'k',1,0);
  figure(1)
  plot (Cylinder)
  plot (EndPlate1)
  plot (EndPlate2)
end

