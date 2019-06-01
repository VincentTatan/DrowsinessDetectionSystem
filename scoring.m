% Read the image for static
% imagename='open19.jpg';
% im1 = imread(strcat('personalimages/',imagename));

%read the image
im1=videoFrame;

% Use the Rule Based Classification and AwakenessProbMatrix to classify 'Awake' and 'Sleepy'
% Mouth	Closing	Split
% Eyes		
% Open	100%	84%
% Close	50&	    15%

awakeprob = [100 85 50 15];

randomnumber = rand(1)*100;

if strcmp(eyestatus ,'open')&&strcmp(mouthstatus,'closing')
    if randomnumber <= awakeprob(1)
        verdict = 'awake';
    else
        verdict = 'sleepy';
    end   
elseif strcmp(eyestatus ,'open')&&strcmp(mouthstatus,'split')
    if randomnumber <= awakeprob(2)
        verdict = 'awake';
    else
        verdict = 'sleepy';
    end
elseif strcmp(eyestatus ,'closed')&&strcmp(mouthstatus,'closing')
    if randomnumber <= awakeprob(3)
        verdict = 'awake';
    else
        verdict = 'sleepy';
    end
else
     if randomnumber <= awakeprob(4)
        verdict = 'awake';
    else
        verdict = 'sleepy';
     end
end

pause(1)