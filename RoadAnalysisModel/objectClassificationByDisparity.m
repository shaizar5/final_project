function objectClassificationByDisparity(matchedPoints,disparity,fig)
   objectsToFind = Constants.NUM_OF_SHAPES;
   idx = kmeans(disparity',objectsToFind);
   
   if (length(idx)~=size(matchedPoints,1))
      length(idx)
      size(matchedPoints,1)
      assert(0);
   end
   
   if (Constants.drawDisparityClassification)
       figure(fig)
       for i=1:size(matchedPoints,1)
           Point = [matchedPoints(i,1)+0.5, matchedPoints(i,2)+0.5];
           if (idx(i)==1)
                plot(Point(1),Point(2), '*r');
           elseif (idx(i)==2)
                plot(Point(1),Point(2), '*g');
           elseif (idx(i)==3)
                plot(Point(1),Point(2), '*m');
           else
                plot(Point(1),Point(2), '*y');
           end
           hold on
       end
   end
end
