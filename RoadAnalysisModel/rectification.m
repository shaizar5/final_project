function rectification(matchedPointsLeft, matchedPointsRight)

[fMatrix, epipolarInliers, status] = estimateFundamentalMatrix(...
  matchedPointsLeft, matchedPointsRight, 'Method', 'RANSAC', ...
  'NumTrials', 10000, 'DistanceThreshold', 0.1, 'Confidence', 99.99);
fMatrix

inlierPoints1 = matchedPointsLeft(epipolarInliers, :);
inlierPoints2 = matchedPointsRight(epipolarInliers, :);



[t1, t2] = estimateUncalibratedRectification(fMatrix, inlierPoints1, inlierPoints2, size(inlierPoints2));


tform1 = projective2d(t1);
tform2 = projective2d(t2);
pts1Rect = transformPointsForward(tform1, inlierPoints1)
pts2Rect = transformPointsForward(tform2, inlierPoints2);

figure(4); clf;
%axis([-100 100 -100 100])
plot(pts1Rect(1,:),pts1Rect(2,:), '*b');
end

