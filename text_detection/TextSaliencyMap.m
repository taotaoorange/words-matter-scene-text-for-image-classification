function TextSaliencyMap(dataset)
    
%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

    current_dir = cd ;
	filename = '.\Images\';
    outputfolder1 = strcat(current_dir,'\curvedness_',dataset);
    outputfolder2 = strcat(current_dir,'\color_',dataset);
 	fprintf('\n Computing Curvature Saliency.'); 
    saliency = strcat(current_dir,'\TextSaliency\TextSaliency.exe');
 	commandline = [saliency ' ' filename ' ' outputfolder1 ' c'];
    tic;
    system(commandline);
    fprintf('Time Consumed: %f',toc);
 	fprintf('\n Computing Color Boosting Saliency.');
 	commandline = [saliency ' ' filename ' ' outputfolder2 ' b'];
 	tic;
    system(commandline); 
    fprintf('Time Consumed: %f',toc);
    
    for color_channel=1:5
    tic;    
	fprintf('\n Feature Integration.\n');
 	TextSaliency(color_channel,filename,dataset);
	fprintf('\nProcess is Done.\n');
    toc
    end
    
end



