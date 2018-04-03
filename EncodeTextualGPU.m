function textual_reprs = EncodeTextualGPU(imageNames, imageDIR, wordBoxDIR)
%
% imageNames: Nx1 cell, list of image names
% imageDIR: image folder
% wordBoxDIR: folder of word proposals

%% setup matconvnet
% run ~/third/matconvnet-1.0-beta18/matlab/vl_setupnn.m

% load model
addpath NIPS2014DLW-Jaderberg/model_release/
net = load('dictnet.mat'); net = vl_simplenn_tidy(net); net = vl_simplenn_move(net, 'gpu');
lexicon = load_nostruct('lex.mat');
nr_lex = length(lexicon);

%%
images = imageNames; nr_images = length(images);

textual_reprs = zeros(nr_lex, nr_images, 'single'); % textual representation
for i = 1:nr_images
    tic;
    % read the image and turn to gray
    im = imread(fullfile(imageDIR,images{i}));
    if size(im, 3) > 1, im = rgb2gray(im); end;

    % read word proposals
    if exist(fullfile(wordBoxDIR,[images{i}(1:end-4) '.mat']),'file') == 0
        continue
    end   
    boxes = importdata(fullfile(wordBoxDIR,[images{i}(1:end-4) '.mat'])); boxes = round(boxes);
    if size(boxes,2) > 4
        boxes = boxes(:,end-3:end);
    end
    if isempty(boxes)
        continue;
    end
    boxes(boxes(:,1)<1, 1) = 1;
    boxes(boxes(:,2)<1, 2) = 1;
    boxes(boxes(:,3)>size(im,2),3) = size(im,2);
    boxes(boxes(:,4)>size(im,1),4) = size(im,1);
    nr_boxes = size(boxes,1);

    %
    box_reprs = zeros(nr_lex, nr_boxes, 'single');
    for j = 1:nr_boxes

        imbox = im(boxes(j,2):boxes(j,4), boxes(j,1):boxes(j,3));
        imbox = imresize(imbox, [32, 100]);

        imbox = single(imbox);
        s = std(imbox(:));
        imbox = imbox - mean(imbox(:));
        imbox = imbox / ((s + 0.0001) / 128.0);
    
        imbox = gpuArray(imbox);
        
        res = vl_simplenn(net, imbox);
        box_reprs(:,j) = gather(res(end).x(:));
    end

    %
    textual_reprs(:,i) = mean(box_reprs,2);  
    
    toc;
    i
    
end