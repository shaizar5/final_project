function disparityAnalysis()
    initialFiguresState('disparity');
    [onRoadPoints, aboveRoadPoints,totalNumOfPoints] = initRoad('disparity');
    roadPoints = [aboveRoadPoints, onRoadPoints];
    Ct = zeros(3,Constants.NUM_OF_STEPS);
   
    projectionMatrixes     = zeros(3,Constants.NUM_OF_STEPS*4);
    roadPointsOnImagePlane = zeros(3,totalNumOfPoints,Constants.NUM_OF_CAMERA_HISTORY);
    roadPoints2d           = zeros(2,totalNumOfPoints,Constants.NUM_OF_CAMERA_HISTORY);
    actualIndices          = zeros(totalNumOfPoints, Constants.NUM_OF_CAMERA_HISTORY);
    pause;
    
    for i=1:Constants.NUM_OF_STEPS
        [f, px, py, mx, my, s] = GetInternalParameters();    
        [R, currCt] = initCamreaByStep(i);
        Ct(:,i) = currCt;
        imagePlane = drawCameraAxis(currCt,R,f,'c');
        figure (1)
        intersectionPoints = lineAndPlaneIntersection(imagePlane, Ct(:,i), Ct(:,i)+50*R(3,:)');
        planeBoundries = calcFOV(Ct(:,i), f, intersectionPoints, R(3,:)');
        drawCameraPlane(planeBoundries);
        P = ProjectionMatrix(R,currCt,f,px,py,mx,my,s);
        projectionMatrixes(:,4*i-3:4*i) = P;
        [currRoadPointsOnImagePlane, currRoadPoints2d, actualPointsIndices] = calc(onRoadPoints, aboveRoadPoints, totalNumOfPoints, planeBoundries, P, currCt, i,R, f);

        if (i<Constants.NUM_OF_CAMERA_HISTORY)
            roadPointsOnImagePlane(:,:,i) = currRoadPointsOnImagePlane;
            roadPoints2d(:,:,i) = currRoadPoints2d;
            actualIndices(:,i) = actualPointsIndices';
            pause;
            continue
        end
        roadPointsOnImagePlane(:,:,Constants.NUM_OF_CAMERA_HISTORY) = currRoadPointsOnImagePlane;
        roadPoints2d(:,:,Constants.NUM_OF_CAMERA_HISTORY) = currRoadPoints2d;
        actualIndices(:,Constants.NUM_OF_CAMERA_HISTORY) = actualPointsIndices';
     
        %classifyPoints(roadPointsOnImagePlane,actualIndices,Ct,i);
        [matchedPointsLeft, matchedPointsRight, matchingIndices] = epipolarLines(projectionMatrixes, Ct, R, roadPoints2d, actualIndices);
        disparity = calcDisparity(matchedPointsLeft, matchedPointsRight);
        drawDisparity(disparity, roadPoints, matchedPointsRight, matchingIndices, Ct(:,2));
        %disparityClassification(roadPoints,matchingIndices, disparity);
 
        draw3dDisparityVolume(disparity, roadPoints, matchingIndices)
        
        roadPointsOnImagePlane(:,:,1) = roadPointsOnImagePlane(:,:,2);
        roadPoints2d(:,:,1) = roadPoints2d(:,:,2);
        actualIndices(:,1) = actualIndices(:,2);
        pause;
    end    
end