function P2 = P2_estimation(matchedPointsLeft, matchedPointsRight, matchingIndices, K)
    P2=[];
    
    H = HomographyEstimation(matchedPointsLeft', matchedPointsRight', 'RANSAC', matchingIndices, K);
end