function disparity = disparityMain(roadPoints, matchedPointsLeft, matchedPointsRight, matchingIndices)
    disparity = calcDisparity(matchedPointsLeft, matchedPointsRight);
    drawDisparity(disparity, roadPoints, matchedPointsLeft, matchedPointsRight, matchingIndices);
    classifiedPoints = disparityClassification(roadPoints,matchingIndices, disparity);

    if (Constants.drawDisparityClassification)
        drawPoints (classifiedPoints, [], 'om')
    end
    
    if (Constants.drawDisparityVolume3d)
       draw3dDisparityVolume(disparity, roadPoints, matchingIndices);
    end
end