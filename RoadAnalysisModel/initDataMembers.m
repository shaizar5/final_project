function [Ct,projectionMatrixes,roadPointsOnImagePlane,roadPoints2d,actualIndices] = initDataMembers(totalNumOfPoints)
    Ct = zeros(3,Constants.NUM_OF_STEPS);
    projectionMatrixes     = zeros(3,4,Constants.NUM_OF_CAMERA_HISTORY);
    roadPointsOnImagePlane = zeros(3,totalNumOfPoints,Constants.NUM_OF_CAMERA_HISTORY);
    roadPoints2d           = zeros(2,totalNumOfPoints,Constants.NUM_OF_CAMERA_HISTORY);
    actualIndices          = zeros(totalNumOfPoints, Constants.NUM_OF_CAMERA_HISTORY);
end

