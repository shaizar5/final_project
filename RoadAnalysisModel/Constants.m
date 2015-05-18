classdef Constants   
    properties (Constant = true)
        EDGE = 1000;
        L=200;
        NUM_OF_STEPS = 1;
        ROAD_WIDTH = 200;
        ROAD_DISTANCE = 1000;
        ABOVE_ROAD_HEIGHT = 200;
        MIN_HEIGHT_ABOVE_ROAD = 2;
        ANGLE_OF_VIEW = 50;
        CAMERA_HEIGHT = 130;
        CAMERA_ROTATION_IN_DEGREES = 50;
        STEP_SIZE = 50;
        NUM_OF_POINT_TO_GENERATE = 10;
        NUM_OF_CAMERA_HISTORY = 2;
        DISPARITY_THRESHOLD=5;

        %mistake variables:
        MIN_STEP_SIZE_MISTAKE = 0;
        MAX_STEP_SIZE_MISTAKE = 0;
        MIN_CAMERA_HEIGHT_MISTAKE = 0;
        MAX_CAMERA_HEIGHT_MISTAKE = 0;
        MIN_CAMERA_ROTATION_IN_DEGREES_MISTAKE = 0;
        MAX_CAMERA_ROTATION_IN_DEGREES_MISTAKE = 0;
        
		NUM_OF_SHAPES = 4;
        FRAMES_PER_SECOND = 10;
        AVERAGE_BLIND_MAN_SPEED = 40; % 0.4 m/s
		
        %draw
        drawRoad = true;
        drawFOVarea = true;
        drawFOVplane = false;
        drawCameraPlane = true;
        drawCameraRoadIntersectionPoints = false;
        drawClassification = false;
        drawEpipole = false;
        drawEpipolarLines = false;
        drawDisparity = false;
        drawDisparityClassification = false;
        drawPointsDistance = false;
        drawPointsIn2dFigures = true;
        draw3dPointsOn2dPlane = true;
        drawPointsIn3d = true;
    end  
end