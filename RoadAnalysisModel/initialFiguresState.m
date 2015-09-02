function initialFiguresState(mode)
clc;
format long % Scaled fixed point output format with 15 digits for double
initFigure3d();
if (~strcmp(mode,'disparity'))
    initFigures2d();
end
drawWorldAxis();
end

function initFigure3d()
figure(1); clf
axis(Constants.EDGE*[-1 1 -1 1 -1 1]);
hold on
grid on
cameratoolbar('Show')
cameratoolbar('SetMode','zoom')
cameratoolbar('SetCoordSys','y')
end

function initFigures2d()
if (Constants.drawPointsIn2dFigures)
    for i=2:Constants.NUM_OF_STEPS+1
        figure(i); clf
        % if changing FOV then need to change this also
        axis([-100 100 -100 100])
    end
end
end

function drawWorldAxis()
L = Constants.L;
figure(1)
text(0,0,0,'w')
plot3([0 L],[0 0],[0 0],'r')
h = text(L,0,0,'Wx');
set(h,'Color','r')
xlabel('x')

plot3([0 0],[0 L],[0 0],'g')
h = text(0,L,0,'Wy');
set(h,'Color','g')
ylabel('y')

plot3([0 0],[0 0],[0 L],'b')
h = text(0,0,L,'Wz');
set(h,'Color','b')
zlabel('z')
end
