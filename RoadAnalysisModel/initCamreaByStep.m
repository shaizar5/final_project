function [R, Ct] = initCamreaByStep(step)

horizon = getXrotation(step);
yaw = getYrotation();
roll = getZrotation();


R = Utilities.rotationMatrix(horizon,yaw,roll)
%end
stepSizeNoise = floor(Constants.MIN_STEP_SIZE_MISTAKE + (Constants.MAX_STEP_SIZE_MISTAKE-Constants.MIN_STEP_SIZE_MISTAKE+1)*rand(1));
stepSizeWithNoise = Constants.AVERAGE_BLIND_MAN_SPEED+stepSizeNoise;
cameraHeightNoise = floor(Constants.MIN_CAMERA_HEIGHT_MISTAKE + (Constants.MAX_CAMERA_HEIGHT_MISTAKE-Constants.MIN_CAMERA_HEIGHT_MISTAKE+1)*rand(1));
cameraHeightWithNoise = Constants.CAMERA_HEIGHT + cameraHeightNoise;

Ct = [0,cameraHeightWithNoise,(step-1)*stepSizeWithNoise*(1/Constants.FRAMES_PER_SECOND)]';
end

function horizon = getXrotation(step)


cameraRotationNoise = floor(Constants.MIN_CAMERA_ROTATION_HORIZON_IN_DEGREES_MISTAKE + (Constants.MAX_CAMERA_ROTATION_HORIZON_IN_DEGREES_MISTAKE-Constants.MIN_CAMERA_ROTATION_HORIZON_IN_DEGREES_MISTAKE+1)*rand(1));
cameraRotationHorizonWithNoise = Constants.CAMERA_ROTATION_HORIZON_IN_DEGREES + cameraRotationNoise;
horizon = degtorad(cameraRotationHorizonWithNoise);
if (Constants.TRANSLATION_VECTOR_UNIT_TEST==1)
    assert (Constants.NUM_OF_STEPS > 2);
    factor = Constants.TRANSLATION_VECTOR_FACTOR;
    global deg
    if (step >2)
        if (deg >=0)
            deg = -(deg+factor);
        else
            deg = -(deg-factor);
        end
    end
    horizon = degtorad(deg);
end
end

function yaw = getYrotation()
cameraRotationNoise = floor(Constants.MIN_CAMERA_ROTATION_YAW_IN_DEGREES_MISTAKE + (Constants.MAX_CAMERA_ROTATION_YAW_IN_DEGREES_MISTAKE-Constants.MIN_CAMERA_ROTATION_YAW_IN_DEGREES_MISTAKE+1)*rand(1));
cameraRotationYawWithNoise = Constants.CAMERA_ROTATION_YAW_IN_DEGREES + cameraRotationNoise;
yaw = degtorad(cameraRotationYawWithNoise);
end

function roll = getZrotation()
cameraRotationNoise = floor(Constants.MIN_CAMERA_ROTATION_ROLL_IN_DEGREES_MISTAKE + (Constants.MAX_CAMERA_ROTATION_ROLL_IN_DEGREES_MISTAKE-Constants.MIN_CAMERA_ROTATION_ROLL_IN_DEGREES_MISTAKE+1)*rand(1));
cameraRotationRollWithNoise = Constants.CAMERA_ROTATION_ROLL_IN_DEGREES + cameraRotationNoise;
roll = degtorad(cameraRotationRollWithNoise);
end