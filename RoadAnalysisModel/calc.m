function [roadPointsOnImagePlane, roadPoints2d, actualPointsIndices] = calc(roadPoints, totalNumOfPoints, planeBoundries, P, currCt, i,R, f)
    [roadPointsOnImagePlane,roadPoints2d,actualPointsIndices] =featuresPoints(roadPoints, planeBoundries, P, currCt, R, f,i);
    sizeRoad = size(roadPointsOnImagePlane,2);
    roadPointsOnImagePlane(:, sizeRoad+1:totalNumOfPoints) = 0;
    roadPoints2d(:, sizeRoad+1:totalNumOfPoints) = 0;
    actualPointsIndices(:, sizeRoad+1:totalNumOfPoints) = 0;
 
    if (Constants.drawPointsDistance)
        drawPointsDistance(roadPoints, sizeRoad, currCt)
    end
end

function [pointsIn3D, points2d, actualPointsIndices] = featuresPoints(points, planeBoundries, P, Ct, R, f,i)
    [actualOnRoadPoints3d, points2d, actualPointsIndices] = project3dPointsToPlane(P, points, planeBoundries);
    if (Constants.drawPointsIn2dFigures)
        figure(i+1)
        hold on
        drawPoints(points2d, '.b');
    end
    pointsIn3D = getImagePointsIn3D(actualOnRoadPoints3d, points2d, Ct, P, R, f, '.m');
end

function drawPointsDistance(roadPoints,totalPoints, currCt)   
    for i=1:totalPoints
        p = roadPoints(:,i);
        text(p(1),p(2)-3,p(3),strcat('\fontsize{8} \color{blue}',num2str(Utilities.distance(p,currCt))))
    end
end