function charGenerateSaliency(color_channel,dataset)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

    addpath(['.\Binarization\'])
		
    test_gt   = '.\Images\';
    files     = dir([test_gt,'*.jpg']);
    
    current_dir = cd ;   
    
    
    imcnt =0;
    
    switch color_channel
        case 1
            cs = 'Gray';
            Significance  = 60;
            Significance2 = 90;
        case 2
            cs = 'S';
            Significance = 80;
            Significance2 = 90;
        case 3
            cs = 'O2';
            Significance = 80;
            Significance2 = 90;
        case 4
            cs = 'O1';
            Significance = 80;
            Significance2 = 90;
        case 5
            cs = 'H';
            Significance = 80;
            Significance2 = 90;
    end
    
    outputfolder = strcat(current_dir,'\BinaryOutPut_',dataset,cs,'\');
    mkdir(outputfolder);
   
    tic;
    for k = 1:length(files)								
		imcnt = imcnt+1;
		
		current_image = files(k,1).name(1:end-4); 
		
		curr_img_drk = strcat('.\SaliencyOutPut_',dataset,cs,'\',current_image,cs,'_letter_darker.jpg');
		I_dark = imread(curr_img_drk); 

        tic;
        try
        [BW_NEW] = eav_thresholding(I_dark,Significance,Significance2);
        catch
        BW_NEW =  I_dark;
        BW_NEW(1:2,1:2) =1;
        end
        folder_name = [outputfolder  strcat(files(k,1).name(1:end-4),cs,'_letter_darker.jpg')];
	    imwrite(uint8(BW_NEW*255), folder_name); 
        
		curr_img_bri = strcat('.\SaliencyOutPut_',dataset,cs,'\',current_image,cs,'_letter_brigther.jpg');
 		I_bright = imread(curr_img_bri);
        try
        [BW_NEW2] = eav_thresholding(I_bright,Significance,Significance2);
        catch
        BW_NEW2 =  I_bright;
        BW_NEW2(1:2,1:2) =1;
        end
        folder_name = [outputfolder  strcat(files(k,1).name(1:end-4),cs,'_letter_brigther.jpg')];
        imwrite(uint8(BW_NEW2*255), folder_name); 
        
 		
    end
   

end