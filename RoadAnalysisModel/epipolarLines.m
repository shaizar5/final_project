function epipolarLines(roadPoints2d, matchedPointsLeft, matchedPointsRight)
    matchPointSize = size(matchedPointsLeft);
    if (matchPointSize(1)<8)
        return
    end
    F = estimateFundamentalMatrix(matchedPointsLeft, matchedPointsRight, 'Method', 'RANSAC', 'NumTrials', 10000, 'DistanceThreshold', 0.1, 'Confidence', 99.99);
    %tform = estimateGeometricTransform(matchedPointsLeft,matchedPointsRight,'similar');
    %tform.T
    er = findEpipol(F, matchedPointsLeft,'left');
    el = findEpipol(F', matchedPointsRight,'right');

    if (Constants.drawEpipolarLines)
        drawEpipolarLines(roadPoints2d(:,:,1), el,2);
        drawEpipolarLines(roadPoints2d(:,:,2), er,3);
    end
    if (Constants.drawEpipole)
        figure(2)
        plot(el(1),el(2), 'g*')
        figure(3)
        plot(er(1),er(2), 'g*')
    end
  %{
    f=50;
    t = getImagePointsIn3D([0;0], el(1:2), Ct(:,1), projectionMatrixes(:,1:4), R, f, 'ro');
    plot3(t(1),t(2),t(3),'g*')
    t = getImagePointsIn3D([0;0], er(1:2), Ct(:,2), projectionMatrixes(:,5:8), R, f, 'ro');
    plot3(t(1),t(2),t(3),'g*')
    %}
end

function epipol = findEpipol(F, matchedPoints,side)
    x1 = [matchedPoints(1,:),1];
    x2 = [matchedPoints(2,:),1];
    if (strcmp(side,'left'))
        l1 = F*x1';
        l2 = F*x2';
        epipol = cross(l1,l2);
    else
        l1 = x1*F;
        l2 = x2*F;
        epipol = cross(l1,l2)';
    end
    
    epipol = Utilities.nonHomogeneousCoords(epipol);
    
end

