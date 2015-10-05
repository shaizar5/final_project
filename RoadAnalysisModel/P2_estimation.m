function P2 = P2_estimation(matchedPointsLeft, matchedPointsRight, matchingIndices, K, step)
global cameraAngleFromLastFrame translation epipolarGeometry

if (step<=2)
    cameraAngleFromLastFrame = zeros(1,Constants.NUM_OF_STEPS-1);
    translation = zeros(1,Constants.NUM_OF_STEPS-1);
end
P2=[];

homographyResult = HomographyEstimation(matchedPointsLeft', matchedPointsRight', matchingIndices, 'RANSAC', K);
epipolarGeometry.roadHomography = homographyResult;
H = homographyResult.T;

% For more info - https://en.wikipedia.org/wiki/Homography_(computer_vision)
Hab = (inv(K)*H*K);
Hab = Hab./Hab(3,3);
focalLength = K(1,1);
lastEpipole = epipolarGeometry.previousFOE;
currEpipole = epipolarGeometry.currentFOE;
dy = currEpipole(2)-lastEpipole(2);
dx = currEpipole(1)-lastEpipole(1);

R = Utilities.rotationMatrix(atan(dy/focalLength), atan(dx/focalLength), 0)';
%R2 = Utilities.rotationX(atan(currEpipole(2)/focalLength))'
%R1 = (R*R2')'

tn = (R-Hab)*Constants.CAMERA_HEIGHT;
t = tn(:,2);
-t(3);

cameraAngleFromLastFrame(step-1) = rad2deg(atan(dy/focalLength));
translation(step-1) = -t(3);

if (Constants.TRANSLATION_VECTOR_UNIT_TEST==1 && step == Constants.NUM_OF_STEPS)
    figure(200); clf
    actual_dz = Constants.AVERAGE_BLIND_MAN_SPEED/Constants.FRAMES_PER_SECOND;
    [xsorted, I] = sort(cameraAngleFromLastFrame);
    ysorted = translation(I);
    plot (xsorted, ysorted, '*', [min(cameraAngleFromLastFrame)-0.1 max(cameraAngleFromLastFrame)+0.1], [actual_dz actual_dz], '--k')
    axis([min(cameraAngleFromLastFrame)-0.1 max(cameraAngleFromLastFrame)+0.1 (min(translation)-5) (max(translation)+5)])
    xlabel('degree of rotation between CamB relative to camA')
    ylabel('translation in cm')
    text(min(cameraAngleFromLastFrame)+0.5,actual_dz-0.5, strcat('perfect Translation = ', num2str(actual_dz)))
    hold on
    if (length(xsorted)>10)
       polynom_degree = 10 ;
    else
        polynom_degree = round(length(ysorted)/2);
    end
    p = polyfit(xsorted,ysorted,polynom_degree);
    x1 = linspace(min(xsorted),max(xsorted));
    y1 = polyval(p,x1);
    plot(x1, y1, '-r')
    
    legend('translation in cm', strcat('perfect translation = ',num2str(actual_dz)), 'polynomial interpolation')
    [xsorted;    ysorted];
    %for i=length(error)
    %    text (error(i), translation(i), num2str(translation(i)))
    %end
end
end