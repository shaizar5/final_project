function res = RANSAC(leftPoints, rightPoints, matchingIndices, computeDirectly, errorFunc, k, numOfIteration, threshDist, inlierRatio, fig)
sizeLeft = size(leftPoints);
sizeRight = size(rightPoints);
bestT = zeros(3,3);
inliers = zeros(1,sizeLeft(2));
outliers = zeros(1,sizeLeft(2));
error = zeros(1,sizeLeft(2));
if (sizeLeft(1) ~= sizeRight(1) || sizeLeft(2) ~= sizeRight(2))
    'input not have same size'
    return
end

totalNumOfPoints = size(leftPoints,2);
bestInNum=0;        % Best fitting T with largest number of inliers
foundOnce=0;
for i=1:numOfIteration
    % randomly choosing n points
    index = randperm(sizeLeft(2),k);
    if (length(unique(index)) ~= length(index))
        ' bad rand function '
        return
    end
    
    % maybe inliers indices
    currLeft  = leftPoints(:,index);
    currRight = rightPoints(:,index);
    T = computeDirectly(currLeft, currRight);
    
    % compute the error between all points
    error = errorFunc(T, leftPoints, rightPoints);
    
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
        bestT = computeDirectly(currLeft, currRight);
    end
    %res = (H*[currLeft(:,1);ones(1,1)]);
    %res = res./res(3);
    %error(i) = norm(res-[currRight(:,1);ones(1,1)]);
end
if (foundOnce==0)
    'error in running RANSAC'
    return
end

error = errorFunc(bestT, leftPoints, rightPoints);
inliers = find(error<=threshDist);
outliers = find(error>threshDist);
res = RansacResults(bestT, inliers, outliers, error);

if (Constants.HOMOGRAPHY_UNIT_TEST==1 || Constants.FUNDEMENTAL_MATRIX_UNIT_TEST==1)
    assert(Constants.NUM_OF_STEPS==2)
    displayUnitTestResults(size(leftPoints), matchingIndices, inliers, outliers, error, k, numOfIteration, threshDist, fig);
end

end

function displayUnitTestResults(sizeLeft, matchingIndices, inliers, outliers, error, k, numOfIteration, threshDist, fig)
    
    figure(fig) ; clf
    s1 = subplot(2,1,1);
    title(s1,'RANSAC')
    res = zeros(1,1000);
    res(:) = max(error)*1.2;
    x = [1,length(res)];
    y = [max(error)*1.1,max(error)*1.1];
    plot(x,y,'-g')
    if (sizeLeft(2) ~=1000)
        text(2,max(error)*1.1, '\uparrow points that not matched between 2 frames')
    end
    hold on
    res(matchingIndices) = error;
    axis([1 length(res) min(res) max(res)])
    plot ([1:length(res)], res, '*')
    hold on
    if (fig==Constants.HOMOGRAPHY_UNIT_TEST_FIGURE)
        add_str = ['Estimation of Homography using RANSAC'];
    elseif (fig==Constants.FUNDEMENTAL_MATRIX_UNIT_TEST_FIGURE)
        add_str = ['Estimation of Fundemental Matrix using RANSAC'];
    end
    str = {add_str, ' ',['#matched points = ',num2str(sizeLeft(2)),' (out of ',num2str(1000),'), k = ',num2str(k),', #iterations = ',num2str(numOfIteration)]};
    title(str)
    x = [Constants.HOMOGRAPHY_UNIT_TEST_ON_ROAD, Constants.HOMOGRAPHY_UNIT_TEST_ON_ROAD];
    y = [0, max(res)];
    plot(x,y,'-r')
    hold on
    subplot(2,1,2);
    axis([1 length(res) min(res) threshDist])
    plot ([1:length(res)], res, '*')
    ylim([0 threshDist])
    perfectNumOfInliers = length(find(matchingIndices<=Constants.HOMOGRAPHY_UNIT_TEST_ON_ROAD));
    perfectNumOfOutliers = length(matchingIndices)-perfectNumOfInliers;
    assert(perfectNumOfInliers+perfectNumOfOutliers==length(matchingIndices), 'error in perferct matching')
    str = ['#inliers = ',num2str(length(inliers)),' (actual ',num2str(perfectNumOfInliers) '), #outliers = ',num2str(length(outliers)),' (actual ',num2str(perfectNumOfOutliers) ')'];
    title(str)
    hold on
    plot(x,y,'-r')
    hold on
end