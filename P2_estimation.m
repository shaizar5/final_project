clc
[f, px, py, mx, my, s] = getInternalParameters();

x0 = mx*px;
y0 = my*py;
alphaX = f*mx;
alphaY = f*my;
K = [alphaX, s, x0;...
    0, alphaY, y0; ...
    0,0,1];

alpha = 0;
R = [1, 0, 0 ; ...
    0, cos(alpha), sin(alpha) ; ...
    0, -sin(alpha), cos(alpha)];


Ct =[    0;   130;     0];


P1 = ProjectionMatrix(R, Ct, f, px, py, mx, my, s )

F = [ 0.000000000000000  -0.028272964322666   0.706824108066643 ; ...
    0.028272964322666  -0.000000000000000  -0.706824108066641; ...
    -0.706824108066643   0.706824108066642   0.000000000000002]


el = [  24.999999999999968; ...
    25.000000000000167; ...
    1.000000000000000];


er =[  24.999999999999972 ; ...
    24.999999999999915; ...
    1.000000000000000];

H = [   1.101255769109685   0.000986524444479                   0; ...
    -0.000986524444479   1.101255769109685                   0; ...
    -2.537609099941004  -2.537103152436018   1.000000000000000]

% H = P2*pinv(P1)
% H*P1 = P2
% K*H*P1 = [R|-R2*C2]

P2 = H*P1;
P2 = P2./P2(3,4)
tmp = inv(K)*P2
R2tmp = tmp(1:3,1:3);
for i=1:3
    R2tmp(i,1:3) = R2tmp(i,1:3)./norm(R2tmp(i,1:3));
end

R2tmp

Fe = Utilities.skewSymmetricMatrix(er)*P2*pinv(P1)
Fh = Utilities.skewSymmetricMatrix(er)*H


[K1, R1, C1] = DecomposeProjectionMatrix(P1)
[K2, R2, C2] = DecomposeProjectionMatrix(P2)

%X=K*pinv(K2)

%K2*X
