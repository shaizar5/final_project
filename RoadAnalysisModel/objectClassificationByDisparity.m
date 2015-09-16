function objectClassificationByDisparity(roadPoints, matchedPointsLeft, matchedPointsRight, matchingIndices,disparity)
   objectsToFind = Constants.NUM_OF_SHAPES;
   idx = kmeans(matchedPointsLeft,objectsToFind);
   figure(Constants.DISPARITY_OBJECT_CLASSIFICATION)
  
   if (Constants.drawDisparityClassification)
       figure(2)
       for i=1:size(matchedPointsLeft,1)
           Point = [matchedPointsLeft(i,1)+0.5, matchedPointsLeft(i,2)+0.5];
           if (idx(i)==1)
                plot(Point(1),Point(2), '*r');
           elseif (idx(i)==2)
                plot(Point(1),Point(2), '*g');
           elseif (idx(i)==3)
                plot(Point(1),Point(2), '*m');
           else
                plot(Point(1),Point(2), '*y');
           end
       end
   end
end
