function draw3dDisparityVolume(disparity, roadPoints, matchingIndices)
    figure(1)
    hold on
    len = size(disparity,2);
    points = zeros(4,len);
    for i=1:len
        index = matchingIndices(i);
        points(:,i) = [roadPoints(:,index);disparity(i)*10];
    end
     
    
    points = sortrows(points',4)';
    points = fliplr(points);
    numberOfStepsFull = length(points(4,:));
    numOfPrints=20;
    fullPoints = points;
    stepSize = floor (numberOfStepsFull/numOfPrints);
   
   for i=1:numOfPrints
      points = fullPoints(:,1:stepSize*i);
      minValue = min(points(4,:));
      maxValue = max(points(4,:));
      numberOfSteps = length(points(4,:));
      histEqVersion = linspace(minValue, maxValue, numberOfSteps); 

      scatter3(points(1,:),points(2,:),points(3,:),10,histEqVersion*100,'fill');
      pause(1);
   end
    %colorbar
end