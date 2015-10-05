function roadAnalysisModel()
%%
clearvars;
% globals
    global deg epipolarGeometry dynamicShape
    deg = Constants.TRANSLATION_VECTOR_INITIAL_DEG;
    epipolarGeometry = EpipolarGeometry;
    dynamicShape = DynamicShape;
%%
    runMode = 'all';
    %secondRunMode = 'dynamic_shape';
    secondRunMode = '';
    initialFiguresState(runMode);
    [roadPoints, totalNumOfPoints] = initRoad(runMode);
    dynamic_shape_points = dynamicShape.generatePoints(Constants.DYNAMIC_SHAPE_NUM_OF_POINTS, Constants.DYNAMIC_SHAPE_LOCATION);
    dynamicShape = dynamicShape.init(Constants.DYNAMIC_SHAPE_LOCATION, dynamic_shape_points', Constants.DYNAMIC_SHAPE_DX);
    [Ct,projectionMatrixes,roadPointsOnImagePlane,roadPoints2d,actualIndices] = initDataMembers(totalNumOfPoints+Constants.DYNAMIC_SHAPE_NUM_OF_POINTS);
    
    pause;
    if (Constants.drawRoad)
        drawRoad()
    end
    
    figure(Constants.MAIN_3D_FIGURE)
    if (Constants.drawPointsIn3d)
        drawPoints (roadPoints, [] , '*b')
    end
    
    numOfSteps=Constants.NUM_OF_STEPS;
    if (strcmp(runMode,'disparity'))
      numOfSteps=2;
    end

    %%
    for step=1:numOfSteps
        % draw dynamic shapes
        if (strcmp(secondRunMode,'dynamic_shape'))
            dynamicShape.points = dynamicShape.points+repmat(dynamicShape.DX,Constants.DYNAMIC_SHAPE_NUM_OF_POINTS,1);
            roadPoints(:,(totalNumOfPoints+1):totalNumOfPoints+Constants.DYNAMIC_SHAPE_NUM_OF_POINTS) = dynamicShape.points';
            %roadPoints(:,(totalNumOfPoints+1):totalNumOfPoints+50) = dynamicShape.points
        end
        i = min(step,Constants.NUM_OF_CAMERA_HISTORY);
        [f, px, py, mx, my, s] = getInternalParameters();    
        [R, currCt] = initCamreaByStep(step);
        Ct(:,i) = currCt;
        imagePlane = drawCameraAxis(currCt,R,f,'c');
        figure (Constants.MAIN_3D_FIGURE)
        intersectionPoints = lineAndPlaneIntersection(imagePlane, Ct(:,i), Ct(:,i)+50*R(3,:)');
        planeBoundries = calcFOV(Ct(:,i), f, intersectionPoints, R(3,:)');

        drawCameraPlane(planeBoundries);
        [projectionMatrixes(:,:,i), K] = ProjectionMatrix(R,currCt,f,px,py,mx,my,s);
        [roadPointsOnImagePlane(:,:,i), roadPoints2d(:,:,i), actualIndices(:,i)] = calc(roadPoints,totalNumOfPoints+Constants.DYNAMIC_SHAPE_NUM_OF_POINTS, planeBoundries, projectionMatrixes(:,:,i), currCt, step,R, f);        
       
        walkingCane(currCt,step);
        
        if (i<Constants.NUM_OF_CAMERA_HISTORY)
             pause;
            continue   
        end
        %%
        % Tracking - used as input to all modules 
        [matchedPointsLeft, matchedPointsRight, matchingIndices] = findMatchingPoints(roadPoints2d, actualIndices);
        %%
        % Dynamic Analysis module
        epipolarLines(roadPoints2d, matchedPointsLeft, matchedPointsRight, matchingIndices, step);
        objectsOpticFlow(matchedPointsLeft, matchedPointsRight)
        %%
        % P2 estimation module
        P2_estimation(matchedPointsLeft, matchedPointsRight, matchingIndices, K, step);
        %%
        % Ground Detector module
        [inliers, outliers] = groundDetectorModule(matchedPointsRight, matchingIndices);

        if (Constants.drawGroundClassification)
            figure(Constants.POINTS_CLASSIFICATION_3D);
            roadPoints3d = roadPoints(:,matchingIndices(inliers));
            abovePoints3d = roadPoints(:,matchingIndices(outliers));
            drawPoints(roadPoints3d, [] , '*g');
            drawPoints(abovePoints3d, matchingIndices(outliers) , '*r');
        end
        figure(Constants.MAIN_3D_FIGURE)
        %%
        % Disaprity calculator
        disparityAll = disparityMain(roadPoints, matchedPointsLeft, matchedPointsRight, matchingIndices);
        disparity = disparityMain(roadPoints, matchedPointsLeft(outliers,:), matchedPointsRight(outliers,:), matchingIndices(outliers));
        
        objectClassificationByDisparity(matchedPointsLeft,disparityAll,Constants.OBJECT_CLASSIFICATION_BY_DISPARITY_ALL);
        objectClassificationByDisparity(matchedPointsLeft(outliers,:),disparity,Constants.OBJECT_CLASSIFICATION_BY_DISPARITY_OUTLIERS);

        %%
        %classifyPoints(roadPointsOnImagePlane,actualIndices,Ct,i);
        
        [roadPointsOnImagePlane,roadPoints2d,actualIndices,projectionMatrixes] = updateHistoryData(roadPointsOnImagePlane,roadPoints2d,actualIndices,projectionMatrixes);
        if (Constants.TRANSLATION_VECTOR_UNIT_TEST~=1)
            pause;
        end
    end    
end