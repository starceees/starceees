%Load the images
i_1 = im2gray(imread("C:\Users\JYOTHI\Documents\MATLAB\images\eifel_1.jpg"));
i_2 = im2gray(imread("C:\Users\JYOTHI\Documents\MATLAB\images\eifel_2.jpg"));
%Resize the images
i_1 = imresize(i_1, [800,400]);
i_2 = imresize(i_2, [800,400]);
%detec the keypoints  using SURF
points1 = detectSURFFeatures(i_1);
points2 = detectSURFFeatures(i_2);
%extract the features and keypoints using SURF
[features1,valid_points1] = extractFeatures(i_1,points1);
[features2,valid_points2] = extractFeatures(i_2,points2);
%Match the features using Brute FOrce to find simmilarities
indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

figure; 
showMatchedFeatures(i_1,i_2,matchedPoints1,matchedPoints2);