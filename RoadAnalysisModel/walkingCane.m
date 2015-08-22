function walkingCane(ct,step)
  if (~Constants.SHOW_WALKING_CANE)
      return
  end
  walkingCaneHand = 1;
  if (~Constants.WALKING_CANE_ON_RIGHT_HAND)
     walkingCaneHand = -1;
  end
  
  changeDir=1;
  if (step>=5 && step<10)
      changeDir = -1;
  end
  newStep = mod(step, 5);
  caneStartPos = ct+[walkingCaneHand*Constants.CANE_DISTANCE_FROM_BODY_CENTER,0,0]';
  caneEndPos = [Constants.CANE_MOVEMENT*newStep*changeDir,0,Constants.CANE_END_POINT_DISTANCE*step]';
  caneRadius = Constants.CANE_RADIUS;
  caneDensity = Constants.CANE_DENSITY;
  [Cylinder, EndPlate1, EndPlate2] = Cylinder3D(caneStartPos,caneEndPos,caneRadius,caneDensity,'k',1,0);
  figure(1)
  plot (Cylinder)
  plot (EndPlate1)
  plot (EndPlate2)
end

