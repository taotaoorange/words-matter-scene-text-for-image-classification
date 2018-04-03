function final_path = word_bb(conns)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

count =1;
keep =[];
words_all(1:length(conns),1:length(conns))=0;
words_all_tmp =1;

while abs(sum(sum(words_all-words_all_tmp)))>0 && count<4

for ll=1:length(conns)

    word = conns{ll};
    
    for mm=1:length(word)
       
      words_all(ll,mm)=word(mm);  
        
    end
    
end


for ll=1:length(conns)

    words = conns{ll};
    
    wordsN =[];
    
    for mm=1:length(words)
    
    [idsx,idsy] = find(words_all==words(mm));
        
    for tt=1:length(idsx)
    wordsN = [wordsN conns{idsx(tt)}];
    end
    
    end
    W_all{ll} = unique(wordsN);
    
end
    conns = W_all;
    clear W_all
    
    words_all_tmp(1:length(conns),1:length(conns))=0;
    
        for ll=1:length(conns)
            word = conns{ll};
            for mm=1:length(word)
              words_all_tmp(ll,mm)=word(mm);  
            end
        end   
        count = count +1;
end

word_num = length(unique(words_all_tmp(:,1)));

ct=1;
for dd=1:size(words_all_tmp,1)    
path_proc = find(words_all_tmp(:,1)==dd);  
if isempty(path_proc)==0
final_path{ct} = path_proc;
ct = ct+1;
end
end


dur =1; 