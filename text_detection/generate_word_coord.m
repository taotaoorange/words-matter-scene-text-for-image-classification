function wd_coord = generate_word_coord(comb,bw)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

wd_coord=[];

for mm=1:length(comb)
   
    pth = comb{mm};
    num = length(pth);
    
    x_min =[];
    y_min =[];
    x_max =[];
    y_max =[];
    
    for ii=1:num
    
        x_min = [x_min,bw(pth(ii)).BoundingBox(1)];
        y_min = [y_min,bw(pth(ii)).BoundingBox(2)];
        
        x_max = [x_max,bw(pth(ii)).BoundingBox(1)+bw(pth(ii)).BoundingBox(3)];
        y_max = [y_max,bw(pth(ii)).BoundingBox(2)+bw(pth(ii)).BoundingBox(4)];
        
    end
    
    wd_coord = [wd_coord;min(x_min) min(y_min) max(x_max) max(y_max);];


end