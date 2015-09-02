classdef DynamicShape
    properties
        location
        points
        DX
    end
    
    methods
        function obj = init(obj,location, points, DX)
            obj.location=location;
            obj.points=points;
            obj.DX=DX;
        end
        
        function points = generatePoints(~,numOfPoints, location)
            points = zeros(3,numOfPoints);
            size=20;
            for i=1:numOfPoints
                points(1,i)= size*rand(1);
                points(2,i)= size*rand(1);
                points(3,i)= size*rand(1);
                points(:,i) = points(:,i) + location';
            end
            
        end
    end
    
end

