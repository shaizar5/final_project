function Plane = drawCameraAxis(Ct,R,f,s)
	% shows the camera coordinate system and finds the plane equation
	% of the camera plane, in World coordinates
	
	% 1. the projection center
	text(Ct(1),Ct(2),Ct(3),s)
	plot3(Ct(1),Ct(2),Ct(3))
	
	% 2. camera axes,
	% R is the rotation from World to camera
	% so here we need its transpose, 
	% from camera to World coordinates:
	
	cx = R'*[Constants.L 0 0]';
	cy = R'*[0 Constants.L 0]';
	cz = R'*[0 0 Constants.L]';
    
	figure(1)
	plot3(   Ct(1)+[0 cx(1)],Ct(2)+[0 cx(2)],Ct(3)+[0 cx(3)],'r')
	h = text(Ct(1)+   cx(1), Ct(2)+   cx(2), Ct(3)+   cx(3),'Cx');
	set(h,'Color','r')
	
	plot3(   Ct(1)+[0 cy(1)],Ct(2)+[0 cy(2)],Ct(3)+[0 cy(3)],'g')
	h = text(Ct(1)+   cy(1), Ct(2)+   cy(2), Ct(3)+   cy(3),'Cy');
	set(h,'Color','g')
	
	plot3(   Ct(1)+[0 cz(1)],Ct(2)+[0 cz(2)],Ct(3)+[0 cz(3)],'b')
	h = text(Ct(1)+   cz(1), Ct(2)+   cz(2), Ct(3)+   cz(3),'Cz');
	set(h,'Color','b')
	
    d = f;
	c1 = R'*[-d -d  f]';
	
	% 3. camera plane
	% find the equation for the camera plane using [a,b,c,d]*[X,Y,Z,1]' = 0
	% or [n,d]*Q = 0
	
	% the normal to the plane is the cross product of 2 vectors in the plane:
	% n = cross(c2-c1,c3-c2); % this gives a,b,c
	% n = n / norm(n);
	
	% or even better, we already have the camera Z axis, which is normal to
	% the plane
	n = univec(cz); % a unit vector in this direction
	
	% now find the d, using some point on the plane, such as Ct + c1
	d = -(n'*(Ct+c1));
	
	Plane = [n'  d];
end

