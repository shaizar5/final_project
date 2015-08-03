function drawPoints (points, actualPointsIndices, prop)
    len = size(points)
    switch len(1)
        case 2
            plot(points(1,:),points(2,:), prop);
            if (Constants.drawPointsIndexes2d)
                l = length(actualPointsIndices)
                for i=1:l
                    text(points(1,i)-2,points(2,i)-2, strcat('\fontsize{8} \color{red}',num2str(actualPointsIndices(i))))
                    
                end
            end
        case 3
            plot3(points(1,:),points(2,:),points(3,:), prop)
    end
end

