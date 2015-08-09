function H = HomographyEstimation(leftPoints, rightPoints, method, K)

if (strcmp(method,'RANSAC'))
    %ransac
    H = RANSAC(leftPoints, rightPoints, 0, round(Constants.NUM_OF_POINT_TO_GENERATE/10), Constants.NUM_OF_POINT_TO_GENERATE, 1.0e-3, 0.1,  K);
else
    % copmute H directly
    
    H = Utilities.computeHdirectly(leftPoints, rightPoints);
    %x= H*[leftPoints;ones(1,sizeLeft(2))];
    %x2 = [x(1,:)./x(3,:) ; x(2,:)./x(3,:) ;x(3,:)./x(3,:) ]
    %[rightPoints;ones(1,sizeLeft(2))]
    %H*[leftPoints(:,1);1];
   
    
    % For more info - https://en.wikipedia.org/wiki/Homography_(computer_vision)
    Hab = (inv(K)*H*K);
    Hab = Hab./Hab(3,3);
    tmp = (eye(3)-Hab)*Constants.CAMERA_HEIGHT;
    t = -round(tmp(:,2));
    
    
end



end

