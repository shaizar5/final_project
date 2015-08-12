function foe = epipolarLines(roadPoints2d, matchedPointsLeft, matchedPointsRight,step)
matchPointSize = size(matchedPointsLeft);
if (matchPointSize(1)<8)
    return
end
F = estimateFundamentalMatrix(matchedPointsLeft, matchedPointsRight, 'Method', 'RANSAC', 'NumTrials', 10000, 'DistanceThreshold', 0.1, 'Confidence', 99.99);

el = findEpipol(F, matchedPointsRight,'right');
er = findSelfEpipol(F, matchedPointsRight);

foe = [el , er];
if (Constants.drawEpipolarLines)
    drawEpipolarLines(roadPoints2d(:,:,2), er,step+1);
end
if (Constants.drawEpipole)
    if (step==2)
        figure(step)
        plot(el(1),el(2), 'g*')
    end
    figure(step+1)
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

function selfEpipol = findSelfEpipol(F, rightPoints)
x1 = [rightPoints(1,:),1];
x2 = [rightPoints(2,:),1];
l1 = x1*F;
l2 = x2*F;

x = 5;
y1 = (-l1(3)-l1(1)*x)/l1(2);
y2 = (-l2(3)-l2(1)*x)/l2(2);
lr1 = F*[x;y1;1];
lr2 = F*[x;y2;1];
selfEpipol = cross(lr1,lr2);
selfEpipol = Utilities.nonHomogeneousCoords(selfEpipol);
selfEpipol = Utilities.doublePrecision(selfEpipol,4);

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
epipol = Utilities.doublePrecision(epipol,4);
end

