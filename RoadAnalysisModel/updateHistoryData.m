function [roadPointsOnImagePlane,roadPoints2d,actualIndices,projectionMatrixes] = updateHistoryData(roadPointsOnImagePlane,roadPoints2d,actualIndices,projectionMatrixes)
    roadPointsOnImagePlane(:,:,1:Constants.NUM_OF_CAMERA_HISTORY-1) = roadPointsOnImagePlane(:,:,2:Constants.NUM_OF_CAMERA_HISTORY);
    roadPoints2d(:,:,1:Constants.NUM_OF_CAMERA_HISTORY-1) = roadPoints2d(:,:,2:Constants.NUM_OF_CAMERA_HISTORY);
    actualIndices(:,1:Constants.NUM_OF_CAMERA_HISTORY-1) = actualIndices(:,2:Constants.NUM_OF_CAMERA_HISTORY);
    projectionMatrixes(:,:,1:Constants.NUM_OF_CAMERA_HISTORY-1) = projectionMatrixes(:,:,2:Constants.NUM_OF_CAMERA_HISTORY);
end

