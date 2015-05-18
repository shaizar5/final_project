classdef Utilities
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
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
    end
    
end

