function objectsOpticFlow(matchedPointsLeft, matchedPointsRight, matchingIndices, step)
    X = matchedPointsRight(:,1);
    Y = matchedPointsRight(:,2);
    dX = matchedPointsRight(:,1)-matchedPointsLeft(:,1);
    dY = matchedPointsRight(:,2)-matchedPointsLeft(:,2);
    
    figure(103)
    quiver(X,Y,dX,dY,2)
    axis([-50 50 -50 50])
end