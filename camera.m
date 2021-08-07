cam = webcam(3)
cam.Brightness = 200
for idx = 1:100
   % Acquire a single image.
   rgbImage = snapshot(cam);

   % Convert RGB to grayscale.
   i = im2gray(rgbImage);
   
   %binary image
   i = im2bw(i,0.7);
   
   i = edge(i, 'sobel');
   [~,threshold] = edge(i,'sobel');
   fudgeFactor = 0.5;
   i = edge(i,'sobel',threshold * fudgeFactor);

   % Display the image.
   imshow(i);
end
clear('cam');