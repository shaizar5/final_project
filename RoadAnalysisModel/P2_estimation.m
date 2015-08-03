function P2 = P2_estimation(matchedPointsLeft, matchedPointsRight, K)
    P2=[];
    
    H = HomographyEstimation(matchedPointsLeft', matchedPointsRight', '', K);
end