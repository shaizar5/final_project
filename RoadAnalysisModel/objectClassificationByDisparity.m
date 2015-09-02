function objectClassificationByDisparity(roadPoints, matchedPointsLeft, matchedPointsRight, matchingIndices,disparity)
   objectsToFind = 3;
   idx = kmeans(disparity',objectsToFind);
   figure(2)
   
   size(matchedPointsLeft,1)
   for i=1:size(matchedPointsLeft,1)
       Point = [matchedPointsLeft(i,1)+0.5, matchedPointsLeft(i,2)+0.5];
       if (idx(i)==1)
            plot(Point(1),Point(2), '*r');
       elseif (idx(i)==2)
            plot(Point(1),Point(2), '*g');
       elseif (idx(i)==3)
            plot(Point(1),Point(2), '*m');
       elseif (idx(i)==4)
            plot(Point(1),Point(2), '*y');
       end
   end
   %{
   length = size(matchingIndices)
   stepSize = 0.1;
   for step = 0:stepSize:50
    for i=0:length
        
    end
   end
   %}
end
