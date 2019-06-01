% Detect sleepy half parted lips

% Read the image for static
% imagename='sleepymouth.jpg';
% im1 = imread(strcat('personalimages/',imagename));

%read the image
 im1=videoFrame;

% Get EyeDetector Object
mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',90);

% Use Mouth Detector on A and get the faces
MouthBBOX =step(mouthDetector,im1);

% Annotate these mouth on the top of the image
imannotatemouth = insertObjectAnnotation(im1,'rectangle',MouthBBOX,'Mouth');

% Getting the last box and crop
MouthBBOX=MouthBBOX(1,:);

% If mouth is above the eyes. Then please discard it
if MouthBBOX(2)<=EyeBBOX(2)+EyeBBOX(4)
     MouthBBOX= [0 0 1 1];
end

binaryImage = imcrop(im1,MouthBBOX);

% Process the image to bw, complement and strel
binaryImage= im2bw(binaryImage,0.4);
binaryImage  = imclose(binaryImage, true(8)); % Close gaps and connect nearby blobs.
binaryImage = imcomplement(binaryImage);
% imshow(binaryImage)
[LabeledIm,ConnectedObj] = bwlabel(binaryImage);

lipsdetected = ConnectedObj;

if lipsdetected>=2
    mouthstatus = 'split';
else
    mouthstatus='closing';
end




