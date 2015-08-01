function [R, Ct] = initCamreaByStep(step)
    cameraRotationNoise = floor(Constants.MIN_CAMERA_ROTATION_IN_DEGREES_MISTAKE + (Constants.MAX_CAMERA_ROTATION_IN_DEGREES_MISTAKE-Constants.MIN_CAMERA_ROTATION_IN_DEGREES_MISTAKE+1)*rand(1));
    cameraRotationWithNoise = Constants.CAMERA_ROTATION_IN_DEGREES + cameraRotationNoise;
    alpha = degtorad(cameraRotationWithNoise);
    R = [1, 0, 0 ; ...
         0, cos(alpha), sin(alpha) ; ...
         0, -sin(alpha), cos(alpha)];

    stepSizeNoise = floor(Constants.MIN_STEP_SIZE_MISTAKE + (Constants.MAX_STEP_SIZE_MISTAKE-Constants.MIN_STEP_SIZE_MISTAKE+1)*rand(1));
    stepSizeWithNoise = Constants.AVERAGE_BLIND_MAN_SPEED+stepSizeNoise;
    cameraHeightNoise = floor(Constants.MIN_CAMERA_HEIGHT_MISTAKE + (Constants.MAX_CAMERA_HEIGHT_MISTAKE-Constants.MIN_CAMERA_HEIGHT_MISTAKE+1)*rand(1));
    cameraHeightWithNoise = Constants.CAMERA_HEIGHT + cameraHeightNoise;
    
	Ct = [0,cameraHeightWithNoise,(step-1)*stepSizeWithNoise*(1/Constants.FRAMES_PER_SECOND)]'; 
end
