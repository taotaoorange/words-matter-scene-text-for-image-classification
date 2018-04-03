load('Finegrained_ImageNames.mat'); imageNames;

t_reprs = EncodeTextualGPU(imageNames, './temp/JPEGImages/', './temp/FinalBoxesFullSet/');
save('./temp/textual_cues.mat', '-v7.3', 't_reprs'); 
