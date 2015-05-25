I1 = rgb2gray(imread('Images\9.jpg'));
I2 = rgb2gray(imread('Images\11.jpg'));

figure(1);
imshowpair(I1, I2,'montage');
title('I1 (left); I2 (right)');
figure(2);
imshowpair(I1,I2,'ColorChannels','red-cyan');
title('Composite Image (Red - Left Image, Cyan - Right Image)');

[ h wim1 ] = homography2d( I1,I2);