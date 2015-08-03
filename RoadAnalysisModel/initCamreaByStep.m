function [R, Ct] = initCamreaByStep(step)
    cameraRotationNoise = floor(Constants.MIN_CAMERA_ROTATION_IN_DEGREES_MISTAKE + (Constants.MAX_CAMERA_ROTATION_IN_DEGREES_MISTAKE-Constants.MIN_CAMERA_ROTATION_IN_DEGREES_MISTAKE+1)*rand(1));
    cameraRotationHorizonWithNoise = Constants.CAMERA_ROTATION_HORIZON_IN_DEGREES + cameraRotationNoise;
    horizon = degtorad(cameraRotationHorizonWithNoise);
    Rx = [1, 0, 0 ; ...
         0, cos(horizon), sin(horizon) ; ...
         0, -sin(horizon), cos(horizon)];

     cameraRotationNoise = floor(Constants.MIN_CAMERA_ROTATION_IN_DEGREES_MISTAKE + (Constants.MAX_CAMERA_ROTATION_IN_DEGREES_MISTAKE-Constants.MIN_CAMERA_ROTATION_IN_DEGREES_MISTAKE+1)*rand(1));
     cameraRotationYawWithNoise = Constants.CAMERA_ROTATION_YAW_IN_DEGREES + cameraRotationNoise;
     yaw = degtorad(cameraRotationYawWithNoise);
     Ry = [cos(yaw),  0, sin(yaw) ; ...
           0,         1,  0; ...
           -sin(yaw), 0, cos(yaw)];
     R = Rx*Ry;
     
    stepSizeNoise = floor(Constants.MIN_STEP_SIZE_MISTAKE + (Constants.MAX_STEP_SIZE_MISTAKE-Constants.MIN_STEP_SIZE_MISTAKE+1)*rand(1));
    stepSizeWithNoise = Constants.AVERAGE_BLIND_MAN_SPEED+stepSizeNoise;
    cameraHeightNoise = floor(Constants.MIN_CAMERA_HEIGHT_MISTAKE + (Constants.MAX_CAMERA_HEIGHT_MISTAKE-Constants.MIN_CAMERA_HEIGHT_MISTAKE+1)*rand(1));
    cameraHeightWithNoise = Constants.CAMERA_HEIGHT + cameraHeightNoise;
    
<<<<<<< HEAD
	Ct = [0,cameraHeightWithNoise,(step-1)*stepSizeWithNoise*(1/Constants.FRAMES_PER_SECOND)]'; 
end
=======
%	Ct = [0,Constants.CAMERA_HEIGHT,(step-1)*Constants.AVERAGE_BLIND_MAN_SPEED*(1/Constants.FRAMES_PER_SECOND)]'; 
    Ct = [0,cameraHeightWithNoise,(step-1)*stepSizeWithNoise]';
end
>>>>>>> a01a1432d2e483af91733308745b3a91c89f5e92
