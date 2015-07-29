function roadAnalysisModel()
    runMode = 'road_points';
    initialFiguresState(runMode);
    [roadPoints, totalNumOfPoints] = initRoad(runMode);
    [Ct,projectionMatrixes,roadPointsOnImagePlane,roadPoints2d,actualIndices] = initDataMembers(totalNumOfPoints);
    pause;
    
    if (Constants.drawPointsIn3d)
        drawPoints (roadPoints, '*b')
    end
    
    for step=1:Constants.NUM_OF_STEPS
        i = min(step,Constants.NUM_OF_CAMERA_HISTORY);
        [f, px, py, mx, my, s] = getInternalParameters();    
        [R, currCt] = initCamreaByStep(step);
        Ct(:,i) = currCt;
        imagePlane = drawCameraAxis(currCt,R,f,'c');
        figure (1)
        intersectionPoints = lineAndPlaneIntersection(imagePlane, Ct(:,i), Ct(:,i)+50*R(3,:)');
        planeBoundries = calcFOV(Ct(:,i), f, intersectionPoints, R(3,:)');
        drawCameraPlane(planeBoundries);
        [projectionMatrixes(:,:,i), K] = ProjectionMatrix(R,currCt,f,px,py,mx,my,s);
        [roadPointsOnImagePlane(:,:,i), roadPoints2d(:,:,i), actualIndices(:,i)] = calc(roadPoints,totalNumOfPoints, planeBoundries, projectionMatrixes(:,:,i), currCt, i,R, f);        
       
        if (i<Constants.NUM_OF_CAMERA_HISTORY)
             pause;
            continue   
        end
       
        %%
        % Tracking - used as input to all modules 
        [matchedPointsLeft, matchedPointsRight, matchingIndices] = findMatchingPoints(roadPoints2d, actualIndices);
        %%
        % Dynamic Analysis module
        epipolarLines(roadPoints2d, matchedPointsLeft, matchedPointsRight);
        %%
        % P2 estimation module
        P2_estimation(matchedPointsLeft, matchedPointsRight, K);
        %%
        % Disaprity calculator
        disparity = calcDisparity(matchedPointsLeft, matchedPointsRight);
        drawDisparity(disparity, roadPoints, matchedPointsRight, matchingIndices, Ct(:,2));
        disparityClassification(roadPoints,matchingIndices, disparity);
        %%
        classifyPoints(roadPointsOnImagePlane,actualIndices,Ct,i);
        if (strcmp(runMode,'disparity'))
            draw3dDisparityVolume(disparity, roadPoints, matchingIndices);
        end
        [roadPointsOnImagePlane,roadPoints2d,actualIndices,projectionMatrixes] = updateHistoryData(roadPointsOnImagePlane,roadPoints2d,actualIndices,projectionMatrixes);
        pause;
    end    
end