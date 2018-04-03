%%
foldID = 0 % 0, 1, 2


%%
nr_class = 28; % con-text dataset

% load image filenames
[filenames,~] = textread(['../metadata/ImageSets/' num2str(foldID) '/1_train.txt'], '%s %d\n');
labels = -1 * ones(length(filenames),1);

for i = 1:nr_class
    
    [dummy, l] = textread(['../metadata/ImageSets/' num2str(foldID) '/' num2str(i) '_train.txt'], '%s %d\n');
    assert(isequal(dummy,filenames))
    
    assert(isequal(labels(l==1),-1*ones(sum(l==1),1)))
    labels(l==1) = i - 1; % from 0
    
    i
end


%% rand
rseed = 1;
rng(rseed);

randp = randperm(length(filenames));
filenames = filenames(randp);
labels = labels(randp);

nr_val = floor(length(filenames)/10); % 10% as val
filenames_val = filenames(1:nr_val);
labels_val = labels(1:nr_val);
filenames_train = filenames(nr_val+1:end);
labels_train = labels(nr_val+1:end);

%% write to file
fid = fopen(['train_lmdb_split_' num2str(foldID) '.txt'],'w');
for i = 1:length(filenames_train)
   fprintf(fid, '%s.jpg %d\n', filenames_train{i}, labels_train(i)); 
end
fclose(fid);

fid = fopen(['val_lmdb_split_' num2str(foldID) '.txt'],'w');
for i = 1:length(filenames_val)
   fprintf(fid, '%s.jpg %d\n', filenames_val{i}, labels_val(i)); 
end
fclose(fid);

