% By Sarah Bertussi and Jennifer Lloyd
function a = yearbookFilter()
%Reminder
disp('REMINDER')
disp('All images must be saved to a folder inside of the MATLAB folder and')
disp('all images must have the format: "Example (1).jpg" for the script to work.')
disp('Also, create the save folder inside of the MATLAB program BEFORE running the')
disp('script. If this has not yet been done, press Ctrl+C, make the adjustments,')
disp('and run again.')
fprintf('\n')

%image testing
totalIMG = input('How many images are in this set? ');
folder = input('In what folder are these images stored? (Put name in single quotes) ');
imgStart = input('What is the common name for the images? (Put name in single quotes) ');
exportFolder = input('In what folder should the images be saved? (Put name in single quotes) ');
exportName = input('What should the common name of the saved images be? (Put name in single quotes) ');

Seconds = 7.5*totalIMG;
Hours = fix(Seconds/60/60);
Seconds = Seconds - (Hours*60*60);
Minutes = fix(Seconds/60);
Seconds = Seconds - (Minutes*60);
fprintf('Estimated time to completion: %d:%d:%d \n', Hours, Minutes, Seconds);

disp('Starting Processing')

for Image_Number = 1:totalIMG
    jpgFileName = sprintf('%s (%d).jpg', imgStart, Image_Number);
    fullFileName = fullfile(folder, jpgFileName);
    
    %RGB mean adjustment
    rgbImage = imread(fullFileName);    
    interR = rgbImage(:, :, 1)+20;
    interG = rgbImage(:, :, 2)+19;
    interB = rgbImage(:, :, 3)+20;

    %S adjustment
    interRGBImage = cat(3, interR, interG, interB);
    interHSVImage = rgb2hsv(interRGBImage);
    newS = interHSVImage(:, :, 2) + 0.1;
    
    newHSVImage = cat(3, interHSVImage(:, :, 1), newS, interHSVImage(:, :, 3));
    newRGBImage = hsv2rgb(newHSVImage);

    baseFileName = sprintf('%s (%d).jpg', exportName, Image_Number);
    fullFileName = fullfile(exportFolder, baseFileName);
    imwrite(newRGBImage, fullFileName);
    
    Image_Number
    
    if(mod(Image_Number,10)== 0)
        Seconds = 7.5*(totalIMG-Image_Number);
        Hours = fix(Seconds/60/60);
        Seconds = Seconds - (Hours*60*60);
        Minutes = fix(Seconds/60);
        Seconds = Seconds - (Minutes*60);
        fprintf('Estimated time to completion: %d:%d:%d \n', Hours, Minutes, Seconds);
    end
end
end
