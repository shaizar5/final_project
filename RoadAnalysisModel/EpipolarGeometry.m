classdef EpipolarGeometry
    properties
        previousFOE
        currentFOE
        roadHomography
        fundementalMatrix
    end
    
    methods
        function drawFOE(~,el,er,index)
            if (Constants.drawEpipole && Constants.drawPointsIn2dFigures)
                if (index==2)
                    figure(index)
                    plot(el(1),el(2), 'g*')
                end
                figure(index+1)
                plot(er(1),er(2), 'g*')
                hold on
            end
        end
    end
end
