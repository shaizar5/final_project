function classifiedPoints = disparityClassification(roadPoints,matchingIndices, disparity)
    classifiedPoints = zeros(3,1);
    
    figure(1)
    len = size(disparity,2);
    counter=1;
    for i=1:len
        if (disparity(i) >= Constants.MIN_DISPARITY_THRESHOLD && disparity(i) <= Constants.MAX_DISPARITY_THRESHOLD)
            classifiedPoints(:,counter) = roadPoints(:,matchingIndices(i));
            counter = counter+1;
        end
    end
end