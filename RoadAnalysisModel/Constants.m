classdef Constants   
    properties (Constant = true)
        EDGE = 1000;
        L=200;
        NUM_OF_STEPS = 2;
        ROAD_WIDTH = 200;
        ROAD_DISTANCE = 2000;
        ABOVE_ROAD_HEIGHT = 200;
        MIN_HEIGHT_ABOVE_ROAD = 2;
        ANGLE_OF_VIEW = 50;
        CAMERA_HEIGHT = 130;
        CAMERA_ROTATION_HORIZON_IN_DEGREES = 0;
        CAMERA_ROTATION_YAW_IN_DEGREES = 0;
        CAMERA_ROTATION_ROLL_IN_DEGREES = 0;
        STEP_SIZE = 150;
        NUM_OF_POINT_TO_GENERATE = 500;
        NUM_OF_CAMERA_HISTORY = 2;
 
        % unit tests
        HOMOGRAPHY_UNIT_TEST = 0;
        HOMOGRAPHY_UNIT_TEST_ON_ROAD = 350;
        HOMOGRAPHY_UNIT_TEST_ABOVE_ROAD = 150;
        FUNDEMENTAL_MATRIX_UNIT_TEST = 0;
        
        TRANSLATION_VECTOR_UNIT_TEST = 1;
        TRANSLATION_VECTOR_INITIAL_DEG = 0;
        TRANSLATION_VECTOR_MAX_DEG = 1.5;
        TRANSLATION_VECTOR_FACTOR = 0.1;
        
        % unit test
        GROUND_DETECTOR_UNIT_TEST = 0;
        
        % figures
        HOMOGRAPHY_UNIT_TEST_FIGURE = 100;
        FUNDEMENTAL_MATRIX_UNIT_TEST_FIGURE = 101;
        GROUND_DETECTOR_FIGURE = 102;
        
        %disparity constants:
        MIN_DISPARITY_THRESHOLD = 5;
        MAX_DISPARITY_THRESHOLD = 50;
        
        %dynamic shape
        DYNAMIC_SHAPE_DX = [50, 10, 0];
        DYNAMIC_SHAPE_LOCATION = [-200,100,400];
        DYNAMIC_SHAPE_NUM_OF_POINTS = 50;
        
        %walking cane constants:
        SHOW_WALKING_CANE = true;
        WALKING_CANE_ON_RIGHT_HAND = 1;
        CANE_DISTANCE_FROM_BODY_CENTER = 20;
        CANE_RADIUS = 2;
        CANE_DENSITY = 50;
        CANE_END_POINT_DISTANCE = 30;
        CANE_MOVEMENT = 5;
        
        %mistake variables constants:
        MIN_STEP_SIZE_MISTAKE = 0;
        MAX_STEP_SIZE_MISTAKE = 0; % m/s
        MIN_CAMERA_HEIGHT_MISTAKE = 0;
        MAX_CAMERA_HEIGHT_MISTAKE = 0;
        MIN_CAMERA_ROTATION_HORIZON_IN_DEGREES_MISTAKE = 0;
        MAX_CAMERA_ROTATION_HORIZON_IN_DEGREES_MISTAKE = 0;
        MIN_CAMERA_ROTATION_YAW_IN_DEGREES_MISTAKE = 0;
        MAX_CAMERA_ROTATION_YAW_IN_DEGREES_MISTAKE = 0;
        MIN_CAMERA_ROTATION_ROLL_IN_DEGREES_MISTAKE = 0;
        MAX_CAMERA_ROTATION_ROLL_IN_DEGREES_MISTAKE = 0;
        
		NUM_OF_SHAPES = 3;
        FRAMES_PER_SECOND = 10;
        AVERAGE_BLIND_MAN_SPEED = 400; % 0.4 m/s
		
        %draw
        drawRoad = true;
        drawFOVarea = false;
        drawFOVplane = false;
        drawCameraPlane = false;
        drawCameraRoadIntersectionPoints = false;
        drawClassification = false;
        drawEpipole = true;
        drawEpipolarLines = false;
        drawDisparity2d = false;
        drawDisparity3d = false;
        drawDisparityClassification = false;
        drawPointsDistance = false;
        drawPointsIn2dFigures = true;
        draw3dPointsOn2dPlane = false;
        drawPointsIn3d = true;
        drawFovBoundries = false;
        drawPointsIndexes2d = false;
        drawPointsIndex3d = false;
        
    end  
end