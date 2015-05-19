function planeBoundries = calcFOV(Ct, focalLength, principlePoint, opticalAxis)
    angleInRadians = degtorad(Constants.ANGLE_OF_VIEW);
    lengthOfX = tan(angleInRadians)*focalLength;
    u = univec(cross(opticalAxis,[-lengthOfX,0,0]'));
    
    edgeLeft = principlePoint+[-lengthOfX,0,0]';
    edgeRight = principlePoint+[lengthOfX,0,0]';
    edgeBottom = principlePoint+lengthOfX*u;
    edgeTop = principlePoint-lengthOfX*u;

    plot3(edgeLeft(1),edgeLeft(2),edgeLeft(3),'ok')
    plot3(edgeRight(1),edgeRight(2),edgeRight(3),'ok')
    plot3(edgeBottom(1),edgeBottom(2),edgeBottom(3),'ok')
    plot3(edgeTop(1),edgeTop(2),edgeTop(3),'ok')

    planeBoundries = [edgeBottom';edgeLeft';edgeTop'; edgeRight'];
        
    plot3(edgeLeft(1),edgeBottom(2),edgeBottom(3),'og') %bottom-left
    plot3(edgeRight(1),edgeBottom(2),edgeBottom(3),'og') %bottom-right
    plot3(edgeLeft(1),edgeTop(2),edgeTop(3),'og') %top-left
    plot3(edgeRight(1),edgeTop(2),edgeTop(3),'og') %top-right
     
    planeLeftBottom = [edgeLeft(1),edgeBottom(2),edgeBottom(3)]';
    planeRightBottom = [edgeRight(1),edgeBottom(2),edgeBottom(3)]';
    planeLeftTop = [edgeLeft(1),edgeTop(2),edgeTop(3)]';
    planeRightTop = [edgeRight(1),edgeTop(2),edgeTop(3)]';
    
    
    u1 = planeLeftBottom-Ct;
    u2 = planeRightBottom-Ct;
    u3 = planeLeftTop-Ct
    %plot3([Ct(1) Ct(1)+50*u3(1)],[Ct(2) Ct(2)+50*u3(2)], [Ct(3) Ct(3)+50*u3(3)],'-k')
    u4 = planeRightTop-Ct

    XZplane = [0,1,0,0];
    XYplane_moved = [0,0,1,-Constants.ROAD_DISTANCE];
    XZleftBottom = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u1);
    XZrightBottom = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u2);
    if (u3(3) >= 0)
        XZleftTop = Ct + 10*u3;
    else
        XZleftTop = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u3);
    end
    tmp = lineAndPlaneIntersection(XYplane_moved, Ct, Ct+50*u3)
    if (XZleftTop(3) > Constants.ROAD_DISTANCE)
        XZleftTop = tmp
    end
    %XZleftTop = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u3);
    if (u4(3) >= 0)
        XZrightTop = Ct + 10*u4;
    else
        XZrightTop = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u4);
    end
    tmp = lineAndPlaneIntersection(XYplane_moved, Ct, Ct+50*u4)
    if (XZrightTop(3) > Constants.ROAD_DISTANCE)
        XZrightTop = tmp
    end
    %XZrightTop = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u4);
    
    plot3(XZleftBottom(1),XZleftBottom(2),XZleftBottom(3),'oy') %bottom-left
    plot3(XZrightBottom(1),XZrightBottom(2),XZrightBottom(3),'om') %bottom-right
    plot3(XZleftTop(1),XZleftTop(2),XZleftTop(3),'ok') %top-left
    plot3(XZrightTop(1),XZrightTop(2),XZrightTop(3),'ob') %top-right
    
    if (XZrightTop==Inf)
        %XZrightTop = [0,0,Constants.ROAD_DISTANCE];
    end
    if (XZleftTop==Inf)
        %XZleftTop = [0,0,Ct(3)];
    end
    drawFOVplane(Ct,XZleftBottom,XZrightBottom,XZleftTop,XZrightTop);

    %plot3([Ct(1) XZleftBottom(1)],[Ct(2) XZleftBottom(2)], [Ct(3) XZleftBottom(3)],'-k')
    %plot3([Ct(1) XZrightBottom(1)],[Ct(2) XZrightBottom(2)], [Ct(3) XZrightBottom(3)],'-k')
    plot3([Ct(1) XZleftTop(1)],[Ct(2) XZleftTop(2)], [Ct(3) XZleftTop(3)],'-k')
    plot3([Ct(1) XZrightTop(1)],[Ct(2) XZrightTop(2)], [Ct(3) XZrightTop(3)],'-k')
end

function drawFOVplane(Ct, XZleftBottom,XZrightBottom,XZleftTop,XZrightTop)
    minZ = min([XZleftTop(3),XZrightTop(3),XZleftBottom(3),XZrightBottom(3)]);
    maxZ = max([XZleftTop(3),XZrightTop(3),XZleftBottom(3),XZrightBottom(3)]);
    
    

    plot3(XZleftBottom(1), 0 ,  minZ,'or') %bottom-left
    plot3(XZrightBottom(1), 0 ,  minZ,'or') %bottom-right
    plot3(XZleftTop(1), XZleftTop(2),  maxZ,'or') %top-left
    plot3(XZrightTop(1), XZrightTop(2) ,  maxZ,'or') %top-right
    
    bottomLeft = [XZleftBottom(1), 0 ,  minZ];
    bottomRight = [XZrightBottom(1), 0 ,  minZ];
    topLeft = [XZleftTop(1), 0 ,  maxZ];
    topRight = [XZrightTop(1), 0 ,  maxZ];
    
    if (Constants.drawFOVplane)
        FovPlane = [bottomLeft; topLeft; topRight; bottomRight];
        fill3 (FovPlane(:,1),FovPlane(:,2),FovPlane(:,3),'y')
        alpha(0.5)
    end

    if (Constants.drawFOVarea)
        
        drawFOVarea([Ct'; XZrightTop(1), XZrightTop(2) ,  maxZ ; XZleftTop(1), XZleftTop(2),  maxZ]);
        drawFOVarea([ Ct'; bottomLeft; topLeft; XZleftTop(1), XZleftTop(2),  maxZ ]);
        drawFOVarea([Ct'; bottomRight; topRight; XZrightTop(1), XZrightTop(2) ,  maxZ]);
        drawFOVarea([Ct'; bottomLeft; bottomRight]);
        
        %drawFOVarea(Ct, bottomLeft, bottomRight);
    end
end

function drawFOVarea(FovArea)
    
    fill3 (FovArea(:,1),FovArea(:,2),FovArea(:,3),'b')
    alpha(0.2)
end