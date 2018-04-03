function rm_id = character_filtering(bw)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

rm_id =[];
for nn =1:length(bw)

    if bw(nn).Solidity ==1 && bw(nn).BoundingBox(4)/bw(nn).BoundingBox(3)<0.5 && bw(nn).Area/(bw(nn).BoundingBox(4)*bw(nn).BoundingBox(3))>0.95 
    rm_id = [rm_id ;nn];
    end
    
end

for nn =1:length(bw)
wd1_asp    = bw(nn).BoundingBox(4);%./bw.BoundingBox(3); 
if wd1_asp<5
 rm_id = [rm_id ;nn];    
end
end





