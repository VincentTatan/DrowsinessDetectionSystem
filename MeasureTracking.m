% Do a looping for every image and create a scoring of each. 
% Keep the image annotation in one place as well

% This is the list to be represented as
imannotateopenmap = containers.Map
improcessopenmap = containers.Map
ratioopenmap = containers.Map
mouthstatusopenmap=containers.Map

numberofphotos=19
for v = 1:numberofphotos

    %read the image open
    imagenameopen = strcat('close',num2str(v),'.jpg');
    
    videoFrame=imread(strcat('personalimages/',imagenameopen));
    EyeDetection
    try
        MouthDetection;
    catch
        mouthstatus='undetected';
    end
    
%     Just to display
        disp(lipsdetected)
        
        
%     Keep the series of all results of Image Open
%     imannotateopenmap(imagenameopen)= imannotateeye
%     improcessopenmap(imagenameopen)= imeye5
%     ratioopenmap(imagenameopen) = ratio
%       improcessopenmapmouth(imagenameopen)= binaryImage
%       mouthstatusopenmap(imagenameopen) = mouthstatus;

end

%    Change this into a list and export it to a csv
%     imagenamelist = ratioopenmap.keys
%     ratioopenlist = ratioopenmap.values
%     d = [imagenamelist, ratioopenlist];
%     dlmwrite('test.csv', d,'-append', 'delimiter', ',');