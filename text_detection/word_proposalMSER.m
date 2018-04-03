function word_proposalMSER(dataset)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

% close all;
% clear all;
warning('off','all');
clc;

    filename   = '.\Images\';
    files     = dir([filename,'*.jpg']);
    
    current_dir = cd ;   

    for color_channel=1:5
    
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
    
    outputfolder = strcat(current_dir,'\WordProposalsMSER_',dataset,cs,'\');
    mkdir(outputfolder);

    test_radius=2.5;
    test_slope=0.2;
    box_num =0;
    tic;
    for k = 1:length(files) 
        
        fprintf('#image num = %d \n',k);
        
        org_im = load(['.\MSEROutPut_',dataset,cs,'\',files(k,1).name(1:end-4)]);
        
        
        orgIM  = imread([filename filesep files(k,1).name(1:end-4) '.jpg']);
        
		current_image = files(k,1).name(1:end-4);
        
        try
        bw1 = org_im.bw;
        rm_id3 = character_filtering(bw1);
        index = true(size(bw1));
        index(rm_id3) = false;
        bw1 = bw1(index);
        clear index rm_id3
        
        
        if length(bw1)>0
        
        for fg =1:length(bw1)
        alan(fg) = bw1(fg).Area;
        end
        % rm_alan = alan<50;
        rm_alan = find(alan<50);
        rm_alan1 = rm_aspect(bw1,orgIM);
        rm_alan2  = unique([rm_alan rm_alan1]);
        index = true(size(bw1));
        index(rm_alan2) = false;
        bw1 = bw1(index);
        clear index alan   
            
        rm1_1 = rm_contrast(bw1, orgIM);
        rm1  = unique([rm1_1]); 
        index = true(size(bw1));
        index(rm1) = false;
        bw1 = bw1(index);
    
        conns1       = word_form(bw1,test_slope,test_radius,orgIM);
        final_path1  = word_bb(conns1);
        final_path1  = SplitTextLineN(final_path1,bw1);
        [comb1,gen1] = create_combSmN(final_path1);
          
        wd_coord1  = generate_word_coord(comb1,bw1);
        % Use to reduce number of word proposals
%         wd1_size   = (wd_coord1(:,3)-wd_coord1(:,1)).*(wd_coord1(:,4)-wd_coord1(:,2)); 
%         wd1_asp    = (wd_coord1(:,4)-wd_coord1(:,2))./(wd_coord1(:,3)-wd_coord1(:,1)); 
%         rm1        = find(wd1_size<300 | wd1_asp>2);
%         index      = ones(size(wd_coord1,1),1);
%         index(rm1) = false;
%         wd_coord1 = wd_coord1(logical(index),:);

        
        word_coord = wd_coord1;
        filePro    = [outputfolder current_image '.mat'];
        save(filePro,'word_coord'); 
        else
            
        word_coord = [];
        filePro    = [outputfolder current_image '.mat'];
        save(filePro,'word_coord'); 
        end
        catch
        word_coord = [];
        filePro    = [outputfolder current_image '.mat'];
        save(filePro,'word_coord');     
        end    
        
        wd_coord = word_coord;
        clear word_coord wd_coord1 wd_coord2 rm1 rm2 index
        
        
%         figure,imshow(orgIM,[]);
%         for nn =1:size(wd_coord,1)
%         rectangle('Position',[wd_coord(nn,1) wd_coord(nn,2) wd_coord(nn,3)-wd_coord(nn,1) wd_coord(nn,4)-wd_coord(nn,2)], 'LineWidth',1, 'EdgeColor',[0 1 0]);
%         end
%         dur=1;  
% 		%pause;
% 		%clf;
% 		dur =1;
		%clc;
        %box_num(k)=size(wd_coord,1);
        %sum(box_num)
    end
    toc
    end