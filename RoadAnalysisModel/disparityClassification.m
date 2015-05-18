function classifiedPoints = disparityClassification(roadPoints,matchingIndices, disparity)
    classifiedPoints = zeros(1,2);
    
    figure(1)
    len = size(disparity,2);
    counter=1;
    for i=1:len
        if (disparity(i) >= Constants.DISPARITY_THRESHOLD)
            index = matchingIndices(i);
            if (Constants.drawDisparityClassification)
                X = roadPoints(:,index);
                plot3(X(1),X(2),X(3),'ok')
                %p = X;
                %text(p(1),p(2)-3,p(3),strcat('\fontsize{12} \color{magenta}',num2str(index)))
            end
            classifiedPoints(counter,:) = index;
            counter = counter+1;
        end
    end
end