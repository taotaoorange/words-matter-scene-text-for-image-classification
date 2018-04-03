function I = SA_TextF(mask,marker1)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

%Saliency Aware Text Finder

	marker(1:size(mask,1),1:size(mask,2)) = 0; 
	marker(1,1:end)=mask(1,1:end); 
	marker(end-1,1:end)=mask(end-1,1:end);  
	marker(1:end,1)=mask(1:end,1);  
	marker(1:end,end-1)=mask(1:end,end-1); 
	marker(find(marker1==0))=mask(find(marker1==0));
	recon = imreconstruct(uint8(marker), uint8(mask));
	I = (double(mask)-double(recon));  
    
    
end
