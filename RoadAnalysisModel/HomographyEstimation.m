function H = HomographyEstimation(leftPoints, rightPoints, method)

if (strcmp(method,'RANSAC'))
    %ransac
    H = RANSAC(leftPoints, rightPoints, 0, 9, Constants.NUM_OF_POINT_TO_GENERATE);
else
    % copmute H directly
    
    sizeLeft = size(leftPoints)
    sizeRight = size(rightPoints)
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
    Hvector = R(:,end);
    H = reshape(Hvector,3,3)';
    H
    %x= H*[leftPoints;ones(1,sizeLeft(2))];
    %x2 = [x(1,:)./x(3,:) ; x(2,:)./x(3,:) ;x(3,:)./x(3,:) ]
    %[rightPoints;ones(1,sizeLeft(2))]
    %H*[leftPoints(:,1);1];
end



end

