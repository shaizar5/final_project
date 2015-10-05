function objectsOpticFlow(matchedPointsLeft, matchedPointsRight)
    X = matchedPointsRight(:,1);
    Y = matchedPointsRight(:,2);
    dX = matchedPointsRight(:,1)-matchedPointsLeft(:,1);
    dY = matchedPointsRight(:,2)-matchedPointsLeft(:,2);
    
    figure(Constants.DISPARITY_OBJECT_CLASSIFICATION)
    quiver(X,Y,dX,dY,2)
    axis([-50 50 -50 50])
end