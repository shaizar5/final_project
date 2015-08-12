function H = HomographyEstimation(leftPoints, rightPoints, method, matchingIndices, K)

if (strcmp(method,'RANSAC'))
    k=10;
    numOfIteration=Constants.NUM_OF_POINT_TO_GENERATE*2;
    threshDist=1.0e-3;
    inliersRatio=0.1;
    [H, inliers, outliers, error] = RANSAC(leftPoints, rightPoints, 0, k, numOfIteration, threshDist, inliersRatio);
    
    if (Constants.HOMOGRAPHY_UNIT_TEST==1)
        assert(Constants.NUM_OF_STEPS==2)
        displayHomographyUnitTest(size(leftPoints), matchingIndices, inliers, outliers, error, k, numOfIteration, threshDist);
    end
    
else
    % copmute H directly    
    H = Utilities.computeHdirectly(leftPoints, rightPoints);
end

end

function displayHomographyUnitTest(sizeLeft, matchingIndices, inliers, outliers, error, k, numOfIteration, threshDist)
     
    figure(100) ; clf
    subplot(2,1,1);
    res = zeros(1,length(matchingIndices));
    res(:) = max(error)*1.2;
    x = [1:length(res)];
    y = [max(error)*1.1];
    plot(x,y,'-g')
    text(100,max(error)+20, '\uparrow points that not matched between 2 frames')
    hold on
    res(matchingIndices) = error;
    axis([1 length(res) min(res) max(res)])
    plot ([1:length(res)], res, '*')
    hold on
    str = ['#matched points = ',num2str(sizeLeft(2)),' (out of ',num2str(Constants.NUM_OF_POINT_TO_GENERATE),'), k = ',num2str(k),', #iterations = ',num2str(numOfIteration)];
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

