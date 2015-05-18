function disparity = calcDisparity(matchedPointsLeft, matchedPointsRight)
    len = size(matchedPointsLeft,1);
    disparity = zeros(1,len);
    
    for i=1:len
        p1 = matchedPointsLeft(i,:);
        p2 = matchedPointsRight(i,:);
        disparity(i) = Utilities.distance(p1,p2);
    end
    
    
end