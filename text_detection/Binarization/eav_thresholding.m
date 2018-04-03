function [BW_NEW] = eav_thresholding(I,Significance_CDF,Significance_PDF)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   ***************************************** 
    
    %[BW_CDF_I,BW_PDF_I] = get_eav_threshold_only(I,Significance_CDF,Significance_PDF);
    J = imclearborder(I);
    [BW_CDF_J] = get_eav_threshold_only(J,Significance_CDF,Significance_PDF);

    %BW_NEW = BW_NEW_I | BW_NEW_J ;
    BW_NEW = bwlabel (BW_CDF_J);
    Sarea=regionprops(BW_NEW,'Area');
    BW_NEW=ismember(BW_NEW, find([Sarea.Area] >= floor(size(I,1)*size(I,2)/30000)));
    BW_NEW=uint8(BW_NEW)*255;

end