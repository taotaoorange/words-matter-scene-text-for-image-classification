function word_coord = expand_border(word_coord,org_im)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************


thrsh_wdth = size(org_im,1);
thrsh_hght = size(org_im,2);

if isempty(word_coord)==0
    hght = word_coord(:,4) - word_coord(:,2);
    wdth = word_coord(:,3) - word_coord(:,1);

    word_coord(:,1) = word_coord(:,1)-10;
    word_coord(:,2) = word_coord(:,2)-5;
    word_coord(:,3) = word_coord(:,3)+10;
    word_coord(:,4) = word_coord(:,4)+5;

    word_coord(find(word_coord(:,1)<0),1) = 1;
    word_coord(find(word_coord(:,2)<0),2) = 1;

    word_coord(find(word_coord(:,3)>thrsh_hght),3) = thrsh_hght;
    word_coord(find(word_coord(:,4)>thrsh_wdth),4) = thrsh_wdth;

else
    word_coord =[];

end