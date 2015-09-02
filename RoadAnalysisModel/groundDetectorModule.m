function [roadPoints, abovePoints, inliers, outliers] = groundDetectorModule(matchedPointsLeft, matchedPointsRight, matchingIndices, step)
    global epipolarGeometry
    inliers = epipolarGeometry.roadHomography.inliers;
    outliers = epipolarGeometry.roadHomography.outliers;
    
    
    roadPoints = matchedPointsRight(inliers,:);
    abovePoints = matchedPointsRight(outliers,:);
    if (Constants.GROUND_DETECTOR_UNIT_TEST == 1)
        figure(Constants.GROUND_DETECTOR_FIGURE); clf ; 
        subplot(2,2,1) , drawPoints (matchedPointsRight', matchingIndices, '.b') , title('Original'), axis([-100 100 -100 100]) , hold on
        epipolarGeometry.drawFOE(epipolarGeometry.previousFOE,epipolarGeometry.currentFOE,Constants.GROUND_DETECTOR_FIGURE-1)
        subplot(2,2,2) , drawPoints (abovePoints', outliers, '.r') , hold on , drawPoints (roadPoints', inliers, '.b') , title('Classified') , axis([-100 100 -100 100]) , hold on
        epipolarGeometry.drawFOE(epipolarGeometry.previousFOE,epipolarGeometry.currentFOE,Constants.GROUND_DETECTOR_FIGURE-1)
        subplot(2,2,3) , drawPoints (roadPoints', inliers, '.b') , title('Road Points') ,  axis([-100 100 -100 100]) , hold on
        epipolarGeometry.drawFOE(epipolarGeometry.previousFOE,epipolarGeometry.currentFOE,Constants.GROUND_DETECTOR_FIGURE-1)
        subplot(2,2,4) , drawPoints (abovePoints', outliers, '.r') , title('Above Road Points') ,  axis([-100 100 -100 100]) , hold on
        epipolarGeometry.drawFOE(epipolarGeometry.previousFOE,epipolarGeometry.currentFOE,Constants.GROUND_DETECTOR_FIGURE-1)
    end
end