function drawEpipolarLines(imagePoints, epipole, fig)
    lenFull = size(imagePoints,2);
    len = sum((sum(imagePoints~=0,1)~=0));
    imagePoints = [imagePoints ; ones(1,lenFull)];
    figure(fig)
    for i=1:len
        l = cross(imagePoints(:,i),epipole);
        DrawEpipolarLine(l, 'r', imagePoints(1:2,i));
        hold on
    end
end

function DrawEpipolarLine(l,c,po)
% c == color
% draw the line l
% po is a 2x1 vector, a point to draw the line around, so we use the x's as
% x = po(1)+-10
    if nargin ==3
        xa = -(po(1)+10);
        xb = -(po(1)-10);
    else
        xa = +4000;
        xb = -4000;
    end
    la = [1 0 xa];   % the line x=-4000
    lb = [1 0 xb];   % the line x=+4000;

    % first intersection
    p = cross(l,la);
    p = p/p(3); % back from homogenuos co-ordinates to x,y
    x1 = p(1);
    y1 = p(2);

    % second intersection
    p = cross(l,lb);
    p = p/p(3); % back from homogenuos co-ordinates to x,y
    x2 = p(1);
    y2 = p(2);

    plot([x1 x2],[y1 y2],c);
end