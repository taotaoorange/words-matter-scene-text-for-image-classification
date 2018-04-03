function evaluateBoxesAllWo_NMS()

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

test_gt   = '.\SVT_Boxes_GT\';
detection = '.\FinalBoxesFullSetNMS\';


files     = dir([test_gt,'*.mat']);
filename = '.\Images\';

recall =0; 
count  =0;
box_num = 0;
ave = 0;
ave_all =0;
cb =0;
for nn=61:length(files)
   
    nn
    org_im = imread([filename files(nn).name(1:end-4) '.jpg']);
    load([test_gt files(nn).name]);
    
    load([detection files(nn).name]);


    x_cmb = word_coord(:,2:5); 
    ids   = word_coord(:,1);
    
    %kpf    = ids==1 | ids == 6;
    %kpf   = ids==1 | ids==2 | ids==3 | ids==4 | ids==5 | ids==6 | ids==7 | ids==8 | ids==9 | ids==10 ;
    kpf   = ids==1 | ids==2 | ids==3 | ids==4 | ids==5 | ids==6 | ids==7 | ids==8 | ids==9 | ids==10;% | ids==3 | ids==4 | ids==5 | ids==6 | ids==7 | ids==8 | ids==9 | ids==10 ;
    
    index = true(size(x_cmb,1),1);
    index = index & kpf;
    x_cmb = x_cmb(index,:);

    box_num(nn) =  size(x_cmb,1);
    
    
    for mm=1:size(boxes,1)
        gt_box = boxes(mm,:);
            
        x_cmb1  = [gt_box;x_cmb];  
        o1      = overlap_pascal(x_cmb1'); 
        [val,id] = sort(o1,'descend');
        ave_all  = ave_all + val(2);
        if length(val)>1
            if val(2)>0.5
                recall=recall+1;
                id_all = find(val(2:end)>0.5);
                ave = ave + sum(val(id_all+1));
                cb = cb + length(find(val(2:end)>0.5));
                
            else
            end
        end
        
        count = count+1;
        R = recall/count
        
%         filePro    = [fldr files(nn).name(1:end-4) '.mat'];
%         word_coord(:,1) = index;
%         save(filePro,'word_coord'); 
   
    end
           
    clear index x_cmb ids_all BoxesKeep
    
end
sum(box_num)
dur =1;