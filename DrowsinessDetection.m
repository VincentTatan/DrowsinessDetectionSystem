% Create the face detector object.
faceDetector = vision.CascadeObjectDetector();

% Create the point tracker object.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Create the webcam object.
cam = webcam();

% The system will keep taking a picture until a person is detected 
while true
    % Capture one frame to get its size.
    disp('Open your eyes wide before picture is taken')
    pause(3)
    videoFrame = snapshot(cam);
    frameSize = size(videoFrame);

    %Use the initial videoframe to generate clean image
    try
        EyeDetection
        initialratio=ratio;
        thresholdratio = initialratio*0.95;
        break
    catch exception
        disp('Person is not detected. please take a picture again')
    end
end
% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);
    
runLoop = true;
numPts = 0;
frameCount = 0;

while runLoop 

    % Get the next frame.
    videoFrame = snapshot(cam);
    
%     prepare 2 seconds of samples
    filename = 'Alarm-TikTok.wav';
    [y,Fs] = audioread(filename);
    samples = [1,2*Fs];
    clear y Fs;
    [y,Fs] = audioread(filename,samples);

%     Prepare sound
    % Classify using EyeDetection
    try
%         This is to detect eyes of the frame and keep comparing with the threshold
        EyeDetection
        disp(['ratio is ',num2str(ratio,3),' threshold is ',num2str(thresholdratio,3)])  ;      

        if ratio >thresholdratio  
            eyestatus='open';
        else
            eyestatus='closed';
        end
%         This is to detect mouth split or not split
        MouthDetection
        disp('Lips detected:  '+lipsdetected);        
        if lipsdetected>=2
            mouthstatus = 'split';
        else
            mouthstatus='closing';
        end

        scoring
        
%         Classify sleepy if your eyes are closed and your mouth is split        
%         if strcmp(eyestatus ,'closed')&&strcmp(mouthstatus,'split')
        if strcmp(verdict,'sleepy')
            disp(['You are ',verdict,'. Mouth is ',mouthstatus,' Eyes are ',eyestatus]);
            sound(y,Fs);
        else
            disp(['You are ',verdict, ' Mouth is ',mouthstatus,' Eyes are ',eyestatus]);
        end
        
    catch exception
        disp('You are not detected');
        sound(y,Fs);
    end
    
% Display a bounding box around the face being tracked.
    videoFrame = insertShape(videoFrame, 'rectangle', EyeBBOX, 'LineWidth', 3);
    videoFrame = insertShape(videoFrame, 'rectangle', MouthBBOX, 'LineWidth', 3);

    % Display the annotated video frame using the video player object.
    step(videoPlayer, videoFrame);
    % Check whether the video player window has been closed.
    runLoop = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);
release(pointTracker);
release(faceDetector);