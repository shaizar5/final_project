function drawCameraPlane(planeBoundries)
    if (Constants.drawCameraPlane)
        edgeBottom = planeBoundries(1,:);
        edgeLeft   = planeBoundries(2,:);
        edgeTop    = planeBoundries(3,:);
        edgeRight  = planeBoundries(4,:);

        plot3 ([edgeRight(1),edgeLeft(1),edgeLeft(1),edgeRight(1),edgeRight(1)],...
               [edgeBottom(2),edgeBottom(2),edgeTop(2),edgeTop(2),edgeBottom(2)],...
               [edgeBottom(3),edgeBottom(3),edgeTop(3),edgeTop(3),edgeBottom(3)],'r')

        %plot3(edgeLeft(1),edgeBottom(2),edgeBottom(3),'ob')
        %plot3(edgeRight(1),edgeBottom(2),edgeBottom(3),'ob')
        %plot3(edgeLeft(1),edgeTop(2),edgeTop(3),'ob')
        %plot3(edgeRight(1),edgeTop(2),edgeTop(3),'ob')
    end
end

