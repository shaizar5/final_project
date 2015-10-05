function res = HomographyEstimation(leftPoints, rightPoints, matchingIndices, method, K)

if (strcmp(method,'RANSAC'))
    k=10;
    numOfIteration=Constants.NUM_OF_POINT_TO_GENERATE*2;
    threshDist=Constants.HOMOGRAPHY_ESTIMATION_THRESH;
    inliersRatio=0.1;
    res = RANSAC(leftPoints, rightPoints, matchingIndices, @computeHdirectly, @measureHomographyError, k, numOfIteration, threshDist, inliersRatio, Constants.HOMOGRAPHY_UNIT_TEST_FIGURE);
else
    % copmute H directly    
    H = computeHdirectly(leftPoints, rightPoints);
    res = RansacResults(H, [], [], []);
end

end

function error=measureHomographyError(H, left, right)
    % measure homography error by:
    % H*p1-p2=0
    res = H*[left;ones(1,size(left,2))];
    res = Utilities.divideMatrixByLastRow(res);
    res = res-[right;ones(1,size(right,2))];
    error = diag(res'*res);
end

function H=computeHdirectly(leftPoints, rightPoints)
    sizeLeft = size(leftPoints);
    sizeRight = size(rightPoints);
    if (sizeLeft(1) ~= sizeRight(1) || sizeLeft(2) ~= sizeRight(2))
        'input not have same size'
        return
    end

    Aodd  = [-leftPoints(1,:)', -leftPoints(2,:)', -ones(1,sizeLeft(2))', zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', rightPoints(1,:)'.*leftPoints(1,:)', rightPoints(1,:)'.*leftPoints(2,:)', rightPoints(1,:)'];
    Aeven = [zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', -leftPoints(1,:)', -leftPoints(2,:)', -ones(1,sizeLeft(2))', rightPoints(2,:)'.*leftPoints(1,:)', rightPoints(2,:)'.*leftPoints(2,:)', rightPoints(2,:)'];

    A = zeros(sizeLeft(2)*2, 9);
    A(1:2:end,:) = Aodd;
    A(2:2:end,:) = Aeven;

    [~,~,R] = svd(A);
    X = R(:,end);
    H = reshape(X,3,3)';
end