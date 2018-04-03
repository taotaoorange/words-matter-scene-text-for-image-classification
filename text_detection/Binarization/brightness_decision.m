function [partioned_image,type]=brightness_decision (image_original,image_edge,steps)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

type = [];
for i = 1:size(steps,1)
    image =  image_original(steps(i,1):steps(i,2),:);
    type = [type, pre_process(image)];
end

partioned_image = [];

for i = 2:size(steps,1)
    
   if type(i-1) ~= type (i)
      
       partioned_image = [partioned_image,i];
   end
       
end