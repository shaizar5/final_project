classdef Utilities  
    properties
    end
    
    methods(Static)
        function v = nonHomogeneousCoords(v)
            s = size(v);
            for i=1:s(2)
                v(:,i) = v(:,i)./v(s(1),i);
            end
        end
        
        function s = skewSymmetricMatrix(v)
            % create the skew symmetric matrix of vector v
            s = [   0 , -v(3) ,  v(2); ...
                v(3),   0   , -v(1); ...
                -v(2),  v(1) ,   0 ];
        end
        
        function dist = distance(p1,p2)
            
            assert(all(size(p1)==size(p2)),'Utilities.distance : p1, p2 are not in same length')
            p3 = p1-p2;
            p3 = p3.*p3;
            dist = sqrt(sum(p3));
        end
        
        function res = divideMatrixByLastRow(A)
            res = A(:,:)./[A(3,:); A(3,:); A(3,:)];
        end
        
        function res = doublePrecision(num, precision)
            res = round(num*(10^(precision)))/(10^(precision)) ;
        end
        
        function R = rotationMatrix(horizon,yaw,roll)
            Rx = Utilities.rotationX(horizon);
            Ry = Utilities.rotationY(yaw);
            Rz = Utilities.rotationZ(roll);
            R = Rz*Ry*Rx;
        end
        
        function Rx = rotationX(horizon)
            Rx = [1, 0, 0 ; ...
                0, cos(horizon), -sin(horizon) ; ...
                0, sin(horizon), cos(horizon)];
        end
        
        function Ry = rotationY(yaw)
            Ry = [cos(yaw),  0, -sin(yaw) ; ...
                0,         1,  0; ...
                sin(yaw), 0, cos(yaw)];
        end
        
        function Rz = rotationZ(roll)
            Rz = [cos(roll), -sin(roll), 0 ; ...
                sin(roll), cos(roll), 0; ...
                0, 0, 1];
        end
    end
    
end

