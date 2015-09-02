function res = fundementalMatrixEstimation(leftPoints, rightPoints, matchingIndices, method)
if (strcmp(method,'RANSAC'))
    k=10;
    numOfIteration=Constants.NUM_OF_POINT_TO_GENERATE*2;
    threshDist=1.0e-10;
    inliersRatio=0.9;
    res = RANSAC(leftPoints, rightPoints, matchingIndices, @computeFdirectly, @measureFundementalMatrixError, k, numOfIteration, threshDist, inliersRatio, Constants.FUNDEMENTAL_MATRIX_UNIT_TEST_FIGURE);
    %{
    if (Constants.HOMOGRAPHY_UNIT_TEST==1)
        assert(Constants.NUM_OF_STEPS==2)
        displayHomographyUnitTest(size(leftPoints), matchingIndices, inliers, outliers, error, k, numOfIteration, threshDist);
    end
    %}
else
    % copmute H directly    
    F = computeFdirectly(leftPoints, rightPoints);
    res = RansacResults(F, [],[],[]);
end
end

function error=measureFundementalMatrixError(F, left, right)
    res = [right;ones(1,size(right,2))]'*F*[left;ones(1,size(left,2))];
    error = diag(abs(res));
end

function F=computeFdirectly(leftPoints, rightPoints)
    sizeLeft = size(leftPoints);
    sizeRight = size(rightPoints);
    if (sizeLeft(1) ~= sizeRight(1) || sizeLeft(2) ~= sizeRight(2))
        'input not have same size'
        return
    end
	
    A = [(rightPoints(1,:).*leftPoints(1,:))', (rightPoints(1,:).*leftPoints(2,:))', rightPoints(1,:)', (rightPoints(2,:).*leftPoints(1,:))', (rightPoints(2,:).*leftPoints(2,:))', rightPoints(2,:)', leftPoints(1,:)', leftPoints(2,:)', ones(1,sizeLeft(2))'];

    [~,~,R] = svd(A);
    X = R(:,end);
    F = reshape(X,3,3)';
end

