function T = RANSAC(leftPoints, rightPoints, func, numOfPoints, numOfIteration)
T = zeros(numOfIteration,1);
sizeLeft = size(leftPoints);
sizeRight = size(rightPoints);
if (sizeLeft(1) ~= sizeRight(1) || sizeLeft(2) ~= sizeRight(2))
    'input not have same size'
    return
end

for i=1:numOfIteration
    index = floor(sizeLeft(2)*rand(1,numOfPoints));
    while ((length(index)~=numOfPoints) || (size(index(index==0),2)>0))
        index = floor(sizeLeft(2)*rand(1,numOfPoints));
    end
    index
    currLeft  = leftPoints(:,index);
    currRight = rightPoints(:,index);
    sizeLeft = size(currLeft)
    sizeRight = size(currRight)
    Aodd  = [-currLeft(1,:)', -currLeft(2,:)', -ones(1,sizeLeft(2))', zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', currRight(1,:)'.*currLeft(1,:)', currRight(1,:)'.*currLeft(2,:)', currRight(1,:)'];
    Aeven = [zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', zeros(1,sizeLeft(2))', -currLeft(1,:)', -currLeft(2,:)', -ones(1,sizeLeft(2))', currRight(2,:)'.*currLeft(1,:)', currRight(2,:)'.*currLeft(2,:)', currRight(2,:)'];
    
    A = zeros(sizeLeft(2)*2, 9);
    A(1:2:end,:) = Aodd;
    A(2:2:end,:) = Aeven;
    
    [~,~,R] = svd(A);
    Hvector = R(:,end);
    H = reshape(Hvector,3,3)'
    
    [currRight(:,1);ones(1,1)]
    res = (H*[currLeft(:,1);ones(1,1)]);
    res = res./res(3)
    error = norm(res-[currRight(:,1);ones(1,1)])
end


end

