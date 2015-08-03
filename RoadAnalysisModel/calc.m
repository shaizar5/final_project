function [roadPointsOnImagePlane, roadPoints2d, actualPointsIndices] = calc(roadPoints, totalNumOfPoints, planeBoundries, P, currCt, i,R, f)
    global once
    once = true;

    [roadPointsOnImagePlane,roadPoints2d,actualPointsIndices] =featuresPoints(roadPoints, planeBoundries, P, currCt, R, f,i);
    sizeRoad = size(roadPointsOnImagePlane,2);
    drawPointsInfo(roadPoints, actualPointsIndices, sizeRoad, currCt)
    
    roadPointsOnImagePlane(:, sizeRoad+1:totalNumOfPoints) = 0;
    roadPoints2d(:, sizeRoad+1:totalNumOfPoints) = 0;
    actualPointsIndices(:, sizeRoad+1:totalNumOfPoints) = 0;
 
    
    
end

function [pointsIn3D, points2d, actualPointsIndices] = featuresPoints(points, planeBoundries, P, Ct, R, f,i)
    [actualOnRoadPoints3d, points2d, actualPointsIndices] = project3dPointsToPlane(P, points, planeBoundries, Ct);
    if (Constants.drawPointsIn2dFigures)
        figure(i+1)
        hold on
        drawPoints(points2d, actualPointsIndices, '.b');
    end
    pointsIn3D = getImagePointsIn3D(actualOnRoadPoints3d, points2d, Ct, P, R, f, '.m');
end

function drawPointsInfo(roadPoints, actualPointsIndices, totalPoints, currCt)   
    global once
    if (~once)
        'out';
        return
    end
    once = false;
    counter=1;
    for i=1:totalPoints
        p = roadPoints(:,i);
        if (Constants.drawPointsDistance)
            text(p(1),p(2)-3,p(3),strcat('\fontsize{8} \color{blue}',num2str(Utilities.distance(p,currCt))))
        elseif(Constants.drawPointsIndex3d)
            if (actualPointsIndices(counter)==i)
                text(p(1),p(2)-3,p(3),strcat('\fontsize{8} \color{blue}',num2str(actualPointsIndices(counter))))
                counter = counter+1;
            end
        end
    end
end