function drawPoints (points, prop)
    len = size(points);
    switch len(1)
        case 2
            plot(points(1,:),points(2,:), prop);
        case 3
            plot3(points(1,:),points(2,:),points(3,:), prop)
    end
end

