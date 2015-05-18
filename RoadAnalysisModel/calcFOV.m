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
     
    edgeLeft = [edgeLeft(1),edgeBottom(2),edgeBottom(3)]';
    edgeRight = [edgeRight(1),edgeBottom(2),edgeBottom(3)]';
    edgeBottom = [edgeLeft(1),edgeTop(2),edgeTop(3)]';
    edgeTop = [edgeRight(1),edgeTop(2),edgeTop(3)]';
    
    u1 = edgeLeft-Ct;
    u2 = edgeRight-Ct;
    u3 = edgeBottom-Ct;
    u4 = edgeTop-Ct;

    XZplane = [0,1,0,0];
    XZleft = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u1);
    XZright = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u2);
    XZbottom = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u3);
    XZtop = lineAndPlaneIntersection(XZplane, Ct, Ct+50*u4);

    
    plot3(XZleft(1),XZleft(2),XZleft(3),'oy') %bottom-left
    plot3(XZright(1),XZright(2),XZright(3),'om') %bottom-right
    plot3(XZbottom(1),XZbottom(2),XZbottom(3),'ok') %top-left
    plot3(XZtop(1),XZtop(2),XZtop(3),'ob') %top-right
    
    if (XZtop==Inf)
        XZtop = [0,0,Constants.ROAD_DISTANCE];
    end
    if (XZbottom==Inf)
        XZbottom = [0,0,Ct(3)];
    end
    drawFOVplane(Ct,XZleft,XZright,XZbottom,XZtop);

    plot3([Ct(1) XZleft(1)],[Ct(2) XZleft(2)], [Ct(3) XZleft(3)],'-k')
    plot3([Ct(1) XZright(1)],[Ct(2) XZright(2)], [Ct(3) XZright(3)],'-k')
    plot3([Ct(1) XZbottom(1)],[Ct(2) XZbottom(2)], [Ct(3) XZbottom(3)],'-k')
    plot3([Ct(1) XZtop(1)],[Ct(2) XZtop(2)], [Ct(3) XZtop(3)],'-k')
end

function drawFOVplane(Ct, XZleft,XZright,XZbottom,XZtop)
    minZ = min([XZbottom(3),XZtop(3),XZleft(3),XZright(1)]);
    maxZ = max([XZbottom(3),XZtop(3),XZleft(3),XZright(1)]);
    
    bottomLeft = [XZleft(1), 0 ,  minZ];
    bottomRight = [XZright(1), 0 ,  minZ];
    topLeft = [XZleft(1), 0 ,  maxZ];
    topRight = [XZright(1), 0 ,  maxZ];

    plot3(bottomLeft(1),bottomLeft(2),bottomLeft(3),'or') %bottom-left
    plot3(bottomRight(1),bottomRight(2),bottomRight(3),'or') %bottom-right
    plot3(topLeft(1),topLeft(2),topLeft(3),'or') %top-left
    plot3(topRight(1),topRight(2),topRight(3),'or') %top-right
    
    if (Constants.drawFOVplane)
        FovPlane = [bottomLeft; topLeft; topRight; bottomRight];
        fill3 (FovPlane(:,1),FovPlane(:,2),FovPlane(:,3),'y')
        alpha(0.5)
    end

    if (Constants.drawFOVarea)
        drawFOVarea(Ct, topLeft, topRight);
        drawFOVarea(Ct, topLeft, bottomLeft);
        drawFOVarea(Ct, topRight, bottomRight);
        drawFOVarea(Ct, bottomLeft, bottomRight);
    end
end

function drawFOVarea(Ct, p1, p2)
    FovArea = [Ct'; p1; p2];
    fill3 (FovArea(:,1),FovArea(:,2),FovArea(:,3),'b')
    alpha(0.2)
end