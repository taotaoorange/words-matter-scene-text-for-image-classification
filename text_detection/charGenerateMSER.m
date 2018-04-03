function charGenerateMSER(dataset)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************


    current_dir = cd ;   
    filename = strcat('.\Images\');
    currentfold= cd;
    cd(filename);
    list = dir ('*.jpg');
    cd(currentfold);
    imcnt =0;
    
    for color_channel =1:5
	
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
    
    outputfolder = strcat(current_dir,'\MSEROutPut_',dataset,cs,'\');
    mkdir(outputfolder);
    
    %tic;
    toc_all =0;
    for k = 1:length(list)	
	
        fprintf('Start Processing File : %s .\n',list(k,1).name(1:end));
		imcnt = imcnt+1;
		
		current_image = list(k,1).name; 
		curr_img_drk = strcat(filename,filesep,current_image);
		
		I = im2double(imread(curr_img_drk));
    
		if size(I,3)<2
        image_pure_gray = 255*I;
        
		else
	
		switch color_channel
			case 1
			image_pure_gray = uint8(255*rgb2gray(I));    
			case 2
			[H,image_pure_gray,V] = rgb2hsv(I);
			image_pure_gray = uint8(image_pure_gray*255);
			case 3
			O2 = (I(:,:,1) + I(:,:,2) - I(:,:,3)*2)/sqrt(6); 
			O2 = (O2+abs(min(min(O2))));
			O2 = uint8(255*(O2/max(max(O2))));    
			image_pure_gray = O2;
			case 4
			O1 = (I(:,:,1) - I(:,:,2))/sqrt(2);
			O1 = (O1+abs(min(min(O1))));
			O1 = uint8(255*(O1/max(max(O1))));
			image_pure_gray = O1;
			case 5
			[image_pure_gray,S,V] = rgb2hsv(I);
			image_pure_gray = uint8(image_pure_gray*255);
		end
		
        end
		
        tic;
        mserRegions = detectMSERFeatures(image_pure_gray,'ThresholdDelta',1,'RegionAreaRange',[150 2000],'MaxAreaVariation',0.15);
   
        
        if mserRegions.Count>1
        mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList)); 
       
        % Convert MSER pixel lists to a binary mask
        mserMask = false(size(image_pure_gray));
        ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
        mserMask(ind) = true;

        BW_NEW = regionprops(mserMask,'area','BoundingBox','Centroid','Solidity');

        for mm=1:length(BW_NEW)
        wd_coord(mm,:) = BW_NEW(mm).BoundingBox;
        end
        
        rm_id1 = find(wd_coord(:,4)>size(I,1)/3);
        rm_id2 = find(wd_coord(:,3)>size(I,2)/3);
        rm_ids = unique([rm_id1' rm_id2'])';
        index = true([size(wd_coord,1) 1]);
        index(rm_ids) = false;
        wd_coord = wd_coord(index,:);
        bw   = BW_NEW(index);
        clear index rm_ids 
        else
        bw = [];    
        end
        %toc

        
        fileNM = [outputfolder list(k,1).name(1:end-4)];
        save (fileNM,'bw')
        
        clear wd_coord bw mserMask ind
 		
    end
    end
    mean(toc_all)

end