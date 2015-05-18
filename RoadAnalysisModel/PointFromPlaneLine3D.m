function [Parallel, q] = PointFromPlaneLine3D(X,P1,V1)
   % function [Parallel q] = PointFromPlaneLine3D(X,P1,V1)
   % finds the 3D point q that is the intersection of a plane and a 3D line.
   %
   % input:
   %    X      1x4      the plane is given by a 4 element row vector.
   %                    the plane normal is X(1:3)
   %
   %    P1     1x3      a 3D point
   %    V1     1x3      a 3d direction vector
   %                    the line is in the format
   %                    P1 + a1 * V1, (P1,v1 row vectors)
   %                    where P1 is a 3D point, a is a scalar and V1 a 3D direction vector.
   %                    a1 (not included in the input) is a parameter that move a
   %                    point along the line, so for each value of a1 there is a point on
   %                    line 1
   %
   % output:
   %    Parallel        a Boolean flag
   %                    if the plane is parallel to V1, return Parallel=1 (and q = Inf),
   %                    else return Parallel = 0 (and the correct q)
   %
   %    q      1x3      the 3d point of intersection between the plane and the line
   %
   %
   % example:
   %
   % A.
   %   the plane at Z=5 is represented by  X = [0,0,1,-5]
   %   the line X=0,Y=Z is represented by  P1 + a*V1 = [0,0,0] + a*[0,1,1]
   %
   %   finding the intersection:
   %
   %      X = [0,0,1,-5];
   %      P1 = [0,0,0];
   %      V1 = [0,1,1];
   %      [Parallel q] = point_from_plane_line_3D(X,P1,V1)
   %
   %   gives Parallel = 0 and q = 0 5 5
   %
   % B.
   %   the line X=0, Z=2 is parallel to the same plane so check it
   %
   %      X = [0,0,1,-5];
   %      P1 = [0,0,2];
   %      V1 = [0,1,0];
   %      [Parallel q] = point_from_plane_line_3D(X,P1,V1)
   %
   %   gives Parallel = 1 and q = Inf
    
   Parallel = 0;
   
   
   % 1. check if the plane and line are parallel by
   %    checking if the plane normal is perpendicular to the line
   if dot(V1,X(1:3)) == 0  % the same as   if V1*X(1:3)' == 0
      Parallel = 1;
      q = Inf;  % the intersection is at infinity. see the help on Inf and Nan.
      return
   end
   
   
   % 2. find the value of a1
   % an intersection of the plane and line implies
   % X*[(P1 + a1 * V1) 1]  = 0
   % solving for a1:
   a1 = -(X*[P1 1]') / ( X(1:3)* V1');
   
   % 3. calc the point
   q = P1 + a1*V1;
   
end
