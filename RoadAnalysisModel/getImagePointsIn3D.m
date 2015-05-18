function imagePointsIn3D = getImagePointsIn3D(actualRoadPoints3d, roadPoints2d, Ct, P, R, f, prop)
    figure(1)
    s = size(roadPoints2d);
    
    if (sum(s)==0)
       imagePointsIn3D = [];
       return
    end
    X = Utilities.nonHomogeneousCoords(pinv(P)*[roadPoints2d;ones(1,s(2))]);
    Z = R'*[0   0  f]';
    imagePointsIn3D = zeros(3,s(2));
    s = size(X);
    for i=1:s(2)
        v = (X(1:3,i) - Ct)./norm(X(1:3,i) - Ct);
        cos_alpha = dot(v,Z./norm(Z));
        A = Ct+(norm(Z)/cos_alpha)*v;
        if (Constants.draw3dPointsOn2dPlane)
            plot3(A(1),A(2),A(3),prop);
        end
        imagePointsIn3D(:,i) = A;
    end
    
    if (Constants.drawCameraRoadIntersectionPoints)
        drawIntersectionPoints(actualRoadPoints3d, Ct)
    end
end

function drawIntersectionPoints(actualRoadPoints3d, Ct)
    figure(1)
    pointsLength = size(actualRoadPoints3d);
    if (pointsLength(2)<=1)
        return
    end
    for i=1:pointsLength(2)
        plot3( [Ct(1) actualRoadPoints3d(1,i)], [Ct(2) actualRoadPoints3d(2,i)], [Ct(3) actualRoadPoints3d(3,i)], '-k')
        hold on
    end
end