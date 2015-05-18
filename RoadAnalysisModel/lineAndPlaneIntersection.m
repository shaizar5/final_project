function intersectionPoints = lineAndPlaneIntersection(imagePlane, Ct, roadPoint)
	% find the interesctions of the lines going from the points through the 
	% camera center to the camera plane
    roadPointLength = length(roadPoint(1,:));    
    intersectionPoints = zeros(3,roadPointLength);
    for i=1:roadPointLength
        [~ , q] = PointFromPlaneLine3D(imagePlane,roadPoint(1:3,i)',(roadPoint(1:3,i)-Ct)');
		intersectionPoints(1:3,i) = q;
    end 
end