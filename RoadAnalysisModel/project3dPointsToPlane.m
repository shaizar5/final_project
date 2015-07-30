function [actualRoadPoints3d, roadPoints2d, indices] = project3dPointsToPlane(P, roadPoint, planeBoundries, Ct)
    roadPoint(4,:)=1
    tmp = P*roadPoint;
    roadPoints2d = [tmp(1,:)./tmp(3,:); tmp(2,:)./tmp(3,:)];
    
    bottom = Utilities.nonHomogeneousCoords(P*[planeBoundries(1,:),1]');
    left = Utilities.nonHomogeneousCoords(P*[planeBoundries(2,:),1]');
    top = Utilities.nonHomogeneousCoords(P*[planeBoundries(3,:),1]');
    right = Utilities.nonHomogeneousCoords(P*[planeBoundries(4,:),1]');
    
    
    counter=1;
    s = size(roadPoints2d);
    tmp = zeros(2,1);
    indices = [];
    for i=1:s(2)
        if (roadPoints2d(1,i) >= left(1) && roadPoints2d(1,i) <= right(1) ...
            && roadPoints2d(2,i) >= bottom(2) && roadPoints2d(2,i) <= top(2) ...
            && roadPoint(3,i)>Ct(3))
            tmp(:,counter)=roadPoints2d(:,i);
            indices(counter) = i;
            counter = counter+1;
        end
    end
    
    if (counter>1)
        actualRoadPoints3d = roadPoint(:,indices(indices~=0));
        roadPoints2d = tmp;
        indices(indices~=0) = indices(indices~=0);
    else
        actualRoadPoints3d = [];
        roadPoints2d =[];
        indices = [];
    end
end