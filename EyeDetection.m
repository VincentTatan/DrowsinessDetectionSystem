% Read the image for static
% imagename='close2.jpg';
% im1 = imread(strcat('personalimages/',imagename));

%read the image
im1=videoFrame;

% Get EyeDetector Object
% EyeDetector =  vision.CascadeObjectDetector('EyePairBig');
EyeDetector =  vision.CascadeObjectDetector('LeftEyeCART');
% only one eyes are used

% Use EyeDetector on A and get the faces
EyeBBOX =step(EyeDetector,im1);

% Annotate these eyes on the top of the image
imannotateeye = insertObjectAnnotation(im1,'rectangle',EyeBBOX,'Eye');

% Getting the last box and crop
EyeBBOX=EyeBBOX(1,:);
imeye3 = imcrop(im1,EyeBBOX);

% Process the image to bw, complement and strel
imeye4=im2bw(imeye3,0.1);
imeye5=imclose(imeye4, strel('sphere',4));


% The number of white pixels is simply the sum of all the image pixel values since each white pixel has value 1.
% If the white pixels have value 255 then divide the sum by 255.
numberOfWhitePixels = sum(imeye5);
% The number of black pixels is simply the total number of pixels in the image minus the number of white pixels.
numberOfBlackPixels = numel(imeye5) - numberOfWhitePixels ;
% Now calculate the ratio.
ratio = numberOfBlackPixels  / numberOfWhitePixels;
