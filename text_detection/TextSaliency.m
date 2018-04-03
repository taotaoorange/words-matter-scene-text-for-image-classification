function TextSaliency(color_channel,filename,dataset)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

switch color_channel
    case 1
        cs = 'Gray';
    case 2
        cs = 'S';
    case 3
        cs = 'O2';
    case 4
        cs = 'O1';
    case 5
        cs = 'H';
end


% filename   = '.\Images\';
list     = dir([filename,'*.jpg']);

current_dir = cd ;   

curvedness = strcat(current_dir,'\curvedness_',dataset,'\');
color = strcat(current_dir,'\color_',dataset,'\');

outputfolder = strcat(current_dir,'\SaliencyOutPut_',dataset,cs,'\');
mkdir(outputfolder);

se=strel('disk',7);    
se3=strel('disk',15);
set(gca, 'position', [0 0 1 1], 'visible', 'off')

for sayac=1:length(list) 
	% close all;
	fprintf('Start Processing File : %s .\n',list(sayac,1).name(1:end-4));
	filename_crvdness =  [strcat(curvedness,list(sayac,1).name(1:end-4),'.jpg')];
	filename_colorbst = [strcat(color,list(sayac,1).name(1:end-4),'.jpg')];
	filename_pure_gray = [filename '\' list(sayac,1).name(1:end-4),'.jpg'];

	I = im2double(imread(filename_pure_gray));
    
    tic;
    if size(I,3)<2
    image_pure_gray = 255*I;
    else
    switch color_channel
        case 1
        image_pure_gray = 255*rgb2gray(I);    
        case 2
        [H,image_pure_gray,V] = rgb2hsv(I);
        image_pure_gray = uint8(image_pure_gray*255);
        case 3
        O2 = (I(:,:,1) + I(:,:,2) - I(:,:,3)*2)/sqrt(6); 
        O2 = (O2+abs(min(min(O2))));
        O2 = (255*(O2/max(max(O2))));    
        image_pure_gray = O2;
        case 4
        O1 = (I(:,:,1) - I(:,:,2))/sqrt(2);
        O1 = (O1+abs(min(min(O1))));
        O1 = (255*(O1/max(max(O1))));
        image_pure_gray = O1;
        case 5
        [image_pure_gray,S,V] = rgb2hsv(I);
        image_pure_gray = uint8(image_pure_gray*255);
    end
    end
       
    try

    image_crvdness = imread(filename_crvdness);  
	image_colorbst = imread(filename_colorbst); 
 
	clear_crvdness = imclearborder(double(image_crvdness));
	clear_colorbst = imclearborder(double(image_colorbst));     
	 
	late_fusion =3*double(clear_crvdness)/4+double(clear_colorbst)/4; 
	h=fspecial('average',[5 5]);
	late_fusion=imfilter(late_fusion,h);
	 
	late_fusion = late_fusion/max(max(late_fusion))*255; 
	if mean2(late_fusion(find(late_fusion>0)))>9
		thresh = 12;
	else
		thresh = mean2(late_fusion(find(late_fusion>0)));
    end

	late_fusion(find(late_fusion<thresh)) =0;
	seed_fusion = late_fusion;

	seed_fusion(find(late_fusion<=1)) =0;
	seed_fusion(find(late_fusion>1)) =1;  

	seed_fusion = bwlabel(seed_fusion);
	seed_fusion(find(seed_fusion>0))=1;
	seed_fusion(1,1:end)=0;
	seed_fusion(end,1:end)=0;
	seed_fusion(1:end,1)=0;
	seed_fusion(1:end,end)=0;
	seed_fusion =imdilate(seed_fusion,se);
	seed_fusion =imerode(seed_fusion,se);

	seed_fusion = imfill(seed_fusion,'holes');
	seed_fusion = imdilate(seed_fusion,se3);

	seeds = bwlabel(seed_fusion);
	stats_box= regionprops(seeds,'Area');

	for aa=1:length(stats_box)
		area_BB(aa)=stats_box(aa,1).Area;
	end

	if length(stats_box)>10
		for aa=1:length(stats_box)    
			if area_BB(aa)<mean(area_BB)/10
				seed_fusion(find(seeds==aa))=0;
			end
		end
    end
    
    catch
    seed_fusion(1:size(image_pure_gray,1),1:size(image_pure_gray,2))=1;    
    seed_fusion(1,1:end) = 0;
    seed_fusion(1:end,1) = 0;
    seed_fusion(end,1:end) = 0;
    seed_fusion(1:end,end) = 0; 
    end    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = SA_TextF(255-image_pure_gray,seed_fusion);
	I(find(I<10))=0;

	I2 = SA_TextF(image_pure_gray,seed_fusion);
    I2(find(I2<10))=0;
 
    clr_channel_nm = cs;
	darker_ending = strcat(clr_channel_nm,'_letter_darker.jpg');
	brighter_ending = strcat(clr_channel_nm,'_letter_brigther.jpg');
	folder_name = [outputfolder  strcat(list(sayac,1).name(1:end-4),darker_ending)];
	imwrite(uint8(I), folder_name); 
	folder_name = [outputfolder  strcat(list(sayac,1).name(1:end-4),brighter_ending)];
	imwrite(uint8(I2),folder_name);
    clear seed_fusion
end