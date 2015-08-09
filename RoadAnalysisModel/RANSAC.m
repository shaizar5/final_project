function T = RANSAC(leftPoints, rightPoints, func, n, numOfIteration, threshDist, inlierRatio,  K)
T = zeros(numOfIteration,1);
sizeLeft = size(leftPoints);
sizeRight = size(rightPoints);
if (sizeLeft(1) ~= sizeRight(1) || sizeLeft(2) ~= sizeRight(2))
    'input not have same size'
    return
end

error = zeros(1,numOfIteration);
totalNumOfPoints = size(leftPoints,2);
bestInNum=0;        % Best fitting H with largest number of inliers
bestH = zeros(3,3);
foundOnce=0;
for i=1:numOfIteration
    % randomly choosing n points
    index = randperm(sizeLeft(2),n);
    if (length(unique(index)) ~= length(index))
        ' bad rand function '
        return
    end
    
    % maybe inliers indices
    currLeft  = leftPoints(:,index);
    currRight = rightPoints(:,index);
    H = Utilities.computeHdirectly(currLeft, currRight);
    
    % compute the error between all points
    error = Utilities.measureHomographyError(H, leftPoints, rightPoints);
    
    % if point fits with an error smaller than t
    inlierIdx = find(error<=threshDist);
    inlierNum = length(inlierIdx);
    
    % if the number of elements is > inlierRatio
    if inlierNum>=round(inlierRatio*totalNumOfPoints) && inlierNum>bestInNum
        % this implies that we may have found a good model
        % now test how good it is
        bestInNum = inlierNum;
        foundOnce=1;
        currLeft  = leftPoints(:,inlierIdx);
        currRight = rightPoints(:,inlierIdx);
        bestH = Utilities.computeHdirectly(currLeft, currRight);
    end
    %res = (H*[currLeft(:,1);ones(1,1)]);
    %res = res./res(3);
    %error(i) = norm(res-[currRight(:,1);ones(1,1)]);
end
if (foundOnce==0)
    'error in running RANSAC'
    return
end
bestInNum
error = Utilities.measureHomographyError(bestH, leftPoints, rightPoints);
figure(4) ; clf
axis([1 length(error) min(error) max(error)])
plot ([1:length(error)], error, '*-')

end

