function [matchedPointsLeft, matchedPointsRight, matchingIndices] = findMatchingPoints(roadPoints2d, actualIndices)
    leftPoints = roadPoints2d(:,:,1);
    rightPoints = roadPoints2d(:,:,2);
    
    iRight = actualIndices(:,2);
    iLeft = actualIndices(:,1);
    
    matchedPointsLeft = zeros(1,2);
    matchedPointsRight = zeros(1,2);
    matchingIndices = [];
    counter=1;
    len = sum(iRight~=0);

    for j=1:len
        currIndex = find(iLeft==iRight(j));
        if (size(currIndex,1)==0)
            continue
        end
        matchedPointsLeft(counter,:) = leftPoints(:, currIndex)';
        matchedPointsRight(counter,:) = rightPoints(:, j)';
        matchingIndices(counter) = iRight(j);
        counter = counter+1;
    end
end