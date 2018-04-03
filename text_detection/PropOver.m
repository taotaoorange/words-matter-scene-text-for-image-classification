function o1 = PropOver(x_cmb)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

    % Compute the features from predictions 
    %
    % Input 
    % cls               string      classname 
    % set               string      test/train/val/trainval
    % detector_folder   string      path for where the Overlapscores are stored
    % gt_folder         string      Pascal ground-truth Main VOC2007\ImageSets\Main\
    % num_of_window     digit       Number of windows to use for mean
    
    
    % Output
    % This script will extract context features and save them per-image

        o1 = zeros(size(x_cmb,2),size(x_cmb,2));

           for ll =1:size(x_cmb,2)

           x1_smaller = zeros(size(x_cmb,2),1);
           x2_smaller = zeros(size(x_cmb,2),1);
           y1_smaller = zeros(size(x_cmb,2),1);
           y2_smaller = zeros(size(x_cmb,2),1);

           x1_smaller(find(x_cmb(1,:) <= x_cmb(1,ll)))=1;  
           y1_smaller(find(x_cmb(2,:) <= x_cmb(2,ll)))=1;  
           x2_smaller(find(x_cmb(3,:) <= x_cmb(3,ll)))=1;  
           y2_smaller(find(x_cmb(4,:) <= x_cmb(4,ll)))=1;   

           xx1                      = zeros(size(x_cmb,2),1);
           xx1(find(x1_smaller==0)) = x_cmb(1,find(x1_smaller==0));
           xx1(find(x1_smaller==1)) = x_cmb(1,ll);

           yy1                      = zeros(size(x_cmb,2),1);
           yy1(find(y1_smaller==0)) = x_cmb(2,find(y1_smaller==0));
           yy1(find(y1_smaller==1)) = x_cmb(2,ll);

           xx2                      = zeros(size(x_cmb,2),1);
           xx2(find(x2_smaller==1)) = x_cmb(3,find(x2_smaller==1));
           xx2(find(x2_smaller==0)) = x_cmb(3,ll);

           yy2                      = zeros(size(x_cmb,2),1);
           yy2(find(y2_smaller==1)) = x_cmb(4,find(y2_smaller==1));
           yy2(find(y2_smaller==0)) = x_cmb(4,ll);

           xx_uni1                  = zeros(size(x_cmb,2),1);
           xx_uni1(find(x1_smaller==1)) = x_cmb(1,find(x1_smaller==1));
           xx_uni1(find(x1_smaller==0)) = x_cmb(1,ll);

           yy_uni1                  = zeros(size(x_cmb,2),1);
           yy_uni1(find(y1_smaller==1)) = x_cmb(2,find(y1_smaller==1));
           yy_uni1(find(y1_smaller==0)) = x_cmb(2,ll);

           xx_uni2                      = zeros(size(x_cmb,2),1);
           xx_uni2(find(x2_smaller==0)) = x_cmb(3,find(x2_smaller==0));
           xx_uni2(find(x2_smaller==1)) = x_cmb(3,ll);

           yy_uni2                      = zeros(size(x_cmb,2),1);
           yy_uni2(find(y2_smaller==0)) = x_cmb(4,find(y2_smaller==0));
           yy_uni2(find(y2_smaller==1)) = x_cmb(4,ll);

           w = xx2-xx1+1; 
           h = yy2-yy1+1;

           w_uni = xx_uni2-xx_uni1+1; 
           h_uni = yy_uni2-yy_uni1+1;

           o1_tmp = w.*h./w_uni./h_uni;

           o1_tmp(find(w<=0))=0;
           o1_tmp(find(h<=0))=0;

           o1(ll,:) =o1_tmp;

           clear o1_tmp w_uni h_uni x1_smaller y1_smaller x2_smaller y2_smaller xx1 xx2 yy1 yy2 xx_uni1 xx_uni2 yy_uni1 yy_uni2

           end 
       



