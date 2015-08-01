function drawDisparity(disparity, roadPoints,matchedPointsLeft, matchedPointsRight, matchingIndices)
    if (Constants.drawDisparity2d)
        draw2dDisparity(disparity, matchedPointsLeft,2);
        draw2dDisparity(disparity, matchedPointsRight,3);
    end
    
    if (Constants.drawDisparity3d)
        draw3dDisparity(disparity, roadPoints, matchingIndices);
    end
end

function draw2dDisparity(disparity, matchedPointsRight, fig)
    figure(fig)
    len = size(disparity,2);
    for i=1:len
        p = matchedPointsRight(i,:);
        text(p(1),p(2)+3,strcat('\fontsize{8}',num2str(disparity(i))))
    end
end

function draw3dDisparity(disparity, roadPoints, matchingIndices)
    figure(1)
    len = size(disparity,2);
    for i=1:len
        index = matchingIndices(i);
        p = roadPoints(:,index);
        %s = '';
        text(p(1),p(2)+3,p(3),strcat(strcat('\fontsize{12} \color{blue}','\fontsize{8}'),num2str(disparity(i))))
    end
end