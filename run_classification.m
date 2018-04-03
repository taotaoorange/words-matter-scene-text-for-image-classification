%% classification script on con-text dataset

%%
foldid = 0; % fold 0 1 2

%% pre-computed kernel matrix
K; % 24255 x 24255 

%% image names, same order as the kernel matrix
load('Finegrained_ImageNames.mat'); imageNames; 


%% setup libsvm


APs = zeros(28,1);
for clsid = 1:28 % 28 classes

    %%
    trainfile = sprintf('metadata/ImageSets/%d/%d_train.txt', foldid, clsid);
    testfile = sprintf('metadata/ImageSets/%d/%d_test.txt', foldid, clsid);
    [trainImageNames, train_labels] = textread(trainfile, '%s\t%f'); trainImageNames = strcat(trainImageNames, '.jpg');
    [testImageNames, test_labels] = textread(testfile, '%s\t%f'); testImageNames = strcat(testImageNames,'.jpg');


    % training images
    f_train = ismember(imageNames, trainImageNames);
    imageNames_sel_train = imageNames(f_train);

    % testing images
    f_test = ismember(imageNames, testImageNames);
    imageNames_sel_test = imageNames(f_test);

    % labels of training images
    labels = -1*ones(length(trainImageNames),1);
    labels(ismember(imageNames_sel_train, trainImageNames(train_labels==1))) = 1;

    % labels of testing images
    labels_t = -1 * ones(length(testImageNames),1);
    labels_t(ismember(imageNames_sel_test,testImageNames(test_labels==1))) = 1;

    %% 

    ker = K(f_train,f_train);

    % training 
    model = svmtrain(labels, [(1:length(trainImageNames))' double(ker)], '-t 4 -c 1'); % '-t 4': precomputed kernel

    % testing
    [predicted_label, accuracy, decision_values] = svmpredict(labels_t, [(1:length(testImageNames))' K(f_test,f_train)], model);

    
    %% compute average precision
    l = labels_t; l(l==-1) = 0;
    ap = ComputeAP(decision_values,l)

    APs(clsid) = ap;
end