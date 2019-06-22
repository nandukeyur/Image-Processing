clc;
clear all
close all
% Read Image
a = (imread('cameraman.tif'));
I = imresize(a,[256 256]);
X = imnoise(I,'Gaussian',0.04,0.003);
 
% Gaussian Filtering of image
fgauss = fspecial('gaussian',[3,3],0.8)
        
filtim1 = imfilter(I,fgauss,'symmetric', 'conv');
        % Filter the image by convolution with the above designed filter.
        % filtim now contains the gaussian filtered image.
figure(1)       
subplot(2,2,1)
imshow(I);
title('Original');
 
subplot(2,2,2)
imshow(X);
title('Image with Noise');
 
subplot(2,2,3)
imshow(filtim1);
title('Gaussian Filtered');
   
% LOG Filter
fplap = [-1 -1 -1; -1 8 -1; -1 -1 -1];      %Laplacian at a point
filtim2 = imfilter(filtim1,fplap,'symmetric', 'conv');
 
for i=1:256
    for j=1:256
if (filtim2(i,j)>20)
    filtim2(i,j) = 0;
else 
    filtim2(i,j)= 255;
end
    end
end
 
subplot(2,2,4)
imshow(filtim2);
title('Laplacian of Guassian Filtered');
 
%Sobel operator
sx=[-1 -2 -1; 0 0 0; 1 2 1];
sy=[-1 0 1; -2 0 2; -1 0 1];
 
I1=im2double(I);
    for i=2:255
        for j=2:255 
         zsx(i,j)=sum(sum(I1(i-1:i+1,j-1:j+1).*sx));
         zsy(i,j)=sum(sum(I1(i-1:i+1,j-1:j+1).*sy));
         zs(i,j) = zsx(i,j)+zsy(i,j);
         
        end
    end
    
 
for i=1:255
    for j=1:255
if (zsx(i,j)>0.1)
    zsx(i,j) = 0;
else 
    zsx(i,j)= 255;
end
    end
end
 
for i=1:255
    for j=1:255
if (zsy(i,j)>0.1)
    zsy(i,j) = 0;
else 
    zsy(i,j)= 255;
end
    end
end
 
 
for i=1:255
    for j=1:255
if (zs(i,j)>0.1)
    zs(i,j) = 0;
else 
    zs(i,j)= 255;
end
    end
end
  
 
figure(2)
subplot(2,2,1)
imshow(I)
title('Original Image')
  
subplot(2,2,2)
imshow(zsx)
title('zsx Sobel Operator')
 
subplot(2,2,3)
imshow(zsy)
title('zsy Sobel Operator')
 
subplot(2,2,4)
imshow(zs)
title('Sobel Operator Final Output')
 
figure(3)
 
subplot(1,2,1)
imshow(zs)
title('Sobel Operator Final Output')
 
subplot(1,2,2)
imshow(filtim2);
title('Laplacian of Guassian Filtered');
