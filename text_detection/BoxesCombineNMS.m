function BoxesCombineNMS(dataset)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

detection1 = ['.\WordProposalsSaliency_' dataset 'Gray\'];
detection2 = ['.\WordProposalsSaliency_' dataset 'S\'];
detection3 = ['.\WordProposalsSaliency_' dataset 'O2\'];
detection4 = ['.\WordProposalsSaliency_' dataset 'O1\'];
detection5 = ['.\WordProposalsSaliency_' dataset 'H\'];

detection6 = ['.\WordProposalsMSER_' dataset 'Gray\'];
detection7 = ['.\WordProposalsMSER_' dataset 'S\'];
detection8 = ['.\WordProposalsMSER_' dataset 'O2\'];
detection9 = ['.\WordProposalsMSER_' dataset 'O1\'];
detection10 =['.\WordProposalsMSER_' dataset 'H\'];


outputfolder = '.\FinalBoxesFullSetNMS\';
mkdir(outputfolder);

filename   = '.\Images\';
files     = dir([filename,'*.jpg']);

box_num = 0;

for nn=1:length(files)
   
    org_im = imread([filename files(nn).name(1:end-4) '.jpg']);
    
    dat1 = load([detection1 files(nn).name(1:end-4)]);
    dat2 = load([detection2 files(nn).name(1:end-4)]);
    dat3 = load([detection3 files(nn).name(1:end-4)]);
    dat4 = load([detection4 files(nn).name(1:end-4)]);
    dat5 = load([detection5 files(nn).name(1:end-4)]);
    dat6 = load([detection6 files(nn).name(1:end-4)]);
    dat7 = load([detection7 files(nn).name(1:end-4)]);
    dat8 = load([detection8 files(nn).name(1:end-4)]);
    dat9 = load([detection9 files(nn).name(1:end-4)]);
    dat10 = load([detection10 files(nn).name(1:end-4)]);
    
    
    word_coord1 = expand_border(dat1.word_coord,org_im);
    id1         = ones(size(word_coord1,1),1);
    word_coord2 = expand_border(dat2.word_coord,org_im);
    id2         = ones(size(word_coord2,1),1)*2;
    word_coord3 = expand_border(dat3.word_coord,org_im);
    id3         = ones(size(word_coord3,1),1)*3;
    word_coord4 = expand_border(dat4.word_coord,org_im);
    id4         = ones(size(word_coord4,1),1)*4;
    word_coord5 = expand_border(dat5.word_coord,org_im);
    id5         = ones(size(word_coord5,1),1)*5;
    word_coord6 = expand_border(dat6.word_coord,org_im);
    id6         = ones(size(word_coord6,1),1)*6;
    word_coord7 = expand_border(dat7.word_coord,org_im);
    id7         = ones(size(word_coord7,1),1)*7;
    word_coord8 = expand_border(dat8.word_coord,org_im);
    id8         = ones(size(word_coord8,1),1)*8;
    word_coord9 = expand_border(dat9.word_coord,org_im);
    id9         = ones(size(word_coord9,1),1)*9;
    word_coord10 = expand_border(dat10.word_coord,org_im);
    id10         = ones(size(word_coord10,1),1)*10;

    x_cmb   = [word_coord1;word_coord2;word_coord3;word_coord4;word_coord5;word_coord6;word_coord7;word_coord8;word_coord9;word_coord10];%];
    ids_all = [id1;id2;id3;id4;id5;id6;id7;id8;id9;id10];
    
    box_num(nn) =  size(x_cmb,1);
    
    keep_id  = word_nms(x_cmb,0.9);
    index = true(size(x_cmb,1),1);
    index(keep_id) = false;
    x_cmb   = x_cmb(index,:);
    ids_all = ids_all(index);
    
    word_coord = [ids_all x_cmb(1:end,:)];
    filePro    = [outputfolder files(nn).name(1:end-4) '.mat'];
    save(filePro,'word_coord'); 

    

    
%    for kk =1:size(x_cmb,1)
%     imshow(org_im,[]);
%     rectangle('Position',[x_cmb(kk,1) x_cmb(kk,2) x_cmb(kk,3)-x_cmb(kk,1) x_cmb(kk,4)-x_cmb(kk,2)], 'LineWidth',1, 'EdgeColor',[0 1 0]);
%    end

    clear index x_cmb ids_all
        
end

dur=1;

