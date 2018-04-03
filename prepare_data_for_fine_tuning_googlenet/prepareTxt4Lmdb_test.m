%%
foldID = 0 % 0,1,2

%%
nr_class = 28;

% load image filenames
[filenames,~] = textread(['../metadata/ImageSets/' num2str(foldID) '/1_test.txt'], '%s %d\n');
labels = -1 * ones(length(filenames),1);

for i = 1:nr_class
    
    [dummy, l] = textread(['../metadata/ImageSets/' num2str(foldID) '/' num2str(i) '_test.txt'], '%s %d\n');
    assert(isequal(dummy,filenames))
    
    assert(isequal(labels(l==1),-1*ones(sum(l==1),1)))
    labels(l==1) = i - 1; % from 0
    
    i
end

%% write to file
fid = fopen(['test_split_' num2str(foldID) '.txt'],'w');
for i = 1:length(filenames)
   fprintf(fid, '%s.jpg %d\n', filenames{i}, labels(i)); 
end
fclose(fid);