function drawDisparity(disparity, roadPoints,matchedPointsLeft, matchedPointsRight, matchingIndices)
    if (Constants.drawDisparity)
        draw2dDisparity(disparity, matchedPointsLeft,2);
        draw2dDisparity(disparity, matchedPointsRight,3);
        draw3dDisparity(disparity, roadPoints, matchingIndices);
        %drawRadius(Ct)
    end
end

function drawRadius()
    figure(1)
    xgv = linspace(-200,200,1000);
    ygv = linspace(-200,200,1000);
    
    [X,Y] = meshgrid(xgv,ygv);
    Z = (4 - X.*2 - Y.*2);
    surf(X,Y,Z)
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
        s = '';%num2str(index);
        text(p(1),p(2)+3,p(3),strcat(strcat(strcat('\fontsize{12} \color{blue}',s),'\fontsize{8}'),num2str(disparity(i))))
    end
end