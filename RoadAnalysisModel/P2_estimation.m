function P2 = P2_estimation(matchedPointsLeft, matchedPointsRight, matchingIndices, K, foe, step)
global error translation

if (step<=2)
    error = zeros(1,Constants.NUM_OF_STEPS-1);
    translation = zeros(1,Constants.NUM_OF_STEPS-1);
end
P2=[];

H = HomographyEstimation(matchedPointsLeft', matchedPointsRight', 'RANSAC', matchingIndices, K);

% For more info - https://en.wikipedia.org/wiki/Homography_(computer_vision)
Hab = (inv(K)*H*K);
Hab = Hab./Hab(3,3);
foe
focalLength = K(1,1);
lastEpipole = foe(:,1);
currEpipole = foe(:,2);
dy = currEpipole(2)-lastEpipole(2);
dx = currEpipole(1)-lastEpipole(1);

R = Utilities.rotationMatrix(atan(dy/focalLength), atan(dx/focalLength), 0)';
%R2 = Utilities.rotationX(atan(currEpipole(2)/focalLength))'
%R1 = (R*R2')'

tn = (R-Hab)*Constants.CAMERA_HEIGHT;
t = tn(:,2);

error(step-1) = rad2deg(atan(dy/focalLength));
translation(step-1) = -t(3);

if (Constants.TRANSLATION_VECTOR_UNIT_TEST==1 && step == Constants.NUM_OF_STEPS)
    figure(200); clf
    actual_dz = Constants.AVERAGE_BLIND_MAN_SPEED/Constants.FRAMES_PER_SECOND;
    axis([min(error) max(error) (min(translation)-5) (max(translation)+5)])
    plot (error, translation, '*')
    xlabel('degree of rotation between CamB relative to camA')
    ylabel(strcat('translation in cm. perfect is  ',num2str(actual_dz)))
    hold on
    plot ([min(error) max(error)], [actual_dz actual_dz], '-r')
    text(-0.5,actual_dz, strcat('Real Translation = ', num2str(actual_dz)))
    [error;    translation]
    %for i=length(error)
    %    text (error(i), translation(i), num2str(translation(i)))
    %end
    
end

end