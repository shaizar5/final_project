classdef RansacResults
    properties
        T
        inliers
        outliers
        error
    end
    
    methods
        function obj = RansacResults(T, inliers, outliers, error)
           obj.T = T;
           obj.inliers = inliers;
           obj.outliers = outliers;
           obj.error = error;
        end
    end
    
end

