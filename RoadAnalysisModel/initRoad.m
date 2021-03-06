function [roadPoints, totalNumOfPoints] = initRoad(mode)
switch mode
    case 'one_on_road_point'
        totalNumOfPoints = 1;
        roadPoints = [20;0;400];
    case 'random' 
        totalNumOfPoints = Constants.NUM_OF_POINT_TO_GENERATE;
        roadPoints = generatePoints(totalNumOfPoints);
        %drawPoints(roadPoints, '*b'); 
    case 'on_above'
        totalNumOfPoints = Constants.NUM_OF_POINT_TO_GENERATE;
        roadPoints = generateOnAndAboveRoad(totalNumOfPoints);
	case 'road_points'
        totalNumOfPoints = Constants.NUM_OF_POINT_TO_GENERATE;
        roadPoints = generateOnAbove(totalNumOfPoints,0);
    case 'disparity'
        roadRight = Constants.ROAD_WIDTH/2;
        roadLeft  = -roadRight;
        roadTop = Constants.ROAD_DISTANCE;
        
        totalNumOfPoints=1;
        for x=roadLeft:10:roadRight
            for y=0:7:50
                for z=5:15:roadTop
                   roadPoints(1,totalNumOfPoints)= x;
                   roadPoints(2,totalNumOfPoints)= y;
                   roadPoints(3,totalNumOfPoints)= z;
                   totalNumOfPoints=totalNumOfPoints+1;
                end
            end
        end
    case 'shapes'
        roadPoints = generatePoints(Constants.NUM_OF_POINT_TO_GENERATE/(Constants.NUM_OF_SHAPES+1));
        for i=1:Constants.NUM_OF_SHAPES
            location = generateLocationInRange();
            aboveRoadPointsSquare = generateSquare(Constants.NUM_OF_POINT_TO_GENERATE/(Constants.NUM_OF_SHAPES+1),location,20);
            roadPoints = [roadPoints,aboveRoadPointsSquare];
        end
        %drawPoints(roadPoints, '*m');
        totalNumOfPoints =Constants.NUM_OF_POINT_TO_GENERATE;
    case 'all'
        %road points:
        totalNumOfPointsOnRoad = Constants.NUM_OF_ROAD_POINTS;
        roadPointsOnRoad = generateOnAbove(totalNumOfPointsOnRoad,0.001);
        
        %shapes:
        roadPointsShapes = [];
        for i=1:Constants.NUM_OF_SHAPES
            location = generateLocationInRange();
            aboveRoadPointsSquare = generateSquare(Constants.NUM_OF_SHAPES_POINTS/(Constants.NUM_OF_SHAPES),location,20);
            roadPointsShapes = [roadPointsShapes,aboveRoadPointsSquare];
        end
        totalNumOfPointsShapes =Constants.NUM_OF_SHAPES_POINTS;

        %random:
        totalNumOfPointsRandom = Constants.NUM_OF_RANDOM_POINTS;
        roadPointsRandom = generatePoints(totalNumOfPointsRandom);
        
        roadPoints = [roadPointsOnRoad, roadPointsShapes,roadPointsRandom];
        totalNumOfPoints = totalNumOfPointsOnRoad + totalNumOfPointsShapes + totalNumOfPointsRandom;
    otherwise
        warning('Error using initRoad')
end
end

function location = generateLocationInRange()
    distance = Constants.ROAD_DISTANCE-100;
    height = Constants.ABOVE_ROAD_HEIGHT;
    width = Constants.ROAD_WIDTH-40;

    location = zeros(1,3);
    location(1)= width*rand(1) + (-width/2);
    location(2)= height*rand(1) + Constants.MIN_HEIGHT_ABOVE_ROAD;
    location(3)= distance*rand(1) + 100;
end

function points = generateSquare(numOfPoints,location, size) 
    points = zeros(3,numOfPoints);
    
    for i=1:numOfPoints
       points(1,i)= size*rand(1) + (-size/2) + location(1)/2;
       points(2,i)= (size*rand(1))+location(2);
       points(3,i)= size*rand(1)+location(3);
    end
end
function points = generatePoints(numOfPoints) 
    points = zeros(3,numOfPoints);
    distance = Constants.ROAD_DISTANCE;
    height = Constants.ABOVE_ROAD_HEIGHT;
    width = Constants.ROAD_WIDTH;
    
    for i=1:numOfPoints
       points(1,i)= width*rand(1) + (-width/2);
       points(2,i)= height*rand(1);
       points(3,i)= distance*rand(1);
    end
end

function points = generateOnAndAboveRoad(numOfPoints) 
    onRoadPoints = generateOnAbove(numOfPoints/2,0);
    aboveRoadPoints = generateOnAbove(numOfPoints/2,1);
    if (Constants.HOMOGRAPHY_UNIT_TEST==1 || Constants.FUNDEMENTAL_MATRIX_UNIT_TEST==1)
        assert((Constants.HOMOGRAPHY_UNIT_TEST_ON_ROAD + Constants.HOMOGRAPHY_UNIT_TEST_ABOVE_ROAD == Constants.NUM_OF_POINT_TO_GENERATE), 'error in HOMOGGRAPHY UNIT TEST')
        onRoadPoints = generateOnAbove(Constants.HOMOGRAPHY_UNIT_TEST_ON_ROAD,0);
        aboveRoadPoints = generateOnAbove(Constants.HOMOGRAPHY_UNIT_TEST_ABOVE_ROAD,1);
    end
    points = [onRoadPoints, aboveRoadPoints];
end

function points = generateOnAbove(numOfPoints,isAboveRoad) 
    points = zeros(3,numOfPoints);
    distance = Constants.ROAD_DISTANCE;
    height = Constants.ABOVE_ROAD_HEIGHT;
    width = Constants.ROAD_WIDTH;
    
    for i=1:numOfPoints
       points(1,i)= width*rand(1) + (-width/2);
       points(2,i)= (height*rand(1) + Constants.MIN_HEIGHT_ABOVE_ROAD)*isAboveRoad;
       points(3,i)= distance*rand(1);
    end
end