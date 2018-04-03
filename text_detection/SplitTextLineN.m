function fp_renew = SplitTextLineN(final_path,bw1)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

fp_renew = {};
count = 0;

for mm=1:length(final_path)
   
    count = count+1;
    pth = final_path{mm};
    num = length(pth);
    
    if num>15 && num<30

    for gh =1:num-1
        distance(gh)  = sqrt(sum(((bw1(pth(gh)).BoundingBox(1)+bw1(pth(gh)).BoundingBox(3)) - (bw1(pth(gh+1)).BoundingBox(1))).^2));
    end
    
    Mdist  = mean(distance);
    Sdist  = std(distance);
    thresh = ceil(Mdist+Sdist*2);
    splits = find(distance>thresh);
    
    if length(splits)>1
        
    for hh=1:length(splits)+1
    
        if hh==1
        fp_renew{count} = pth(1:splits(hh));
        count = count+1;
        else if hh~=length(splits)+1
        fp_renew{count} = pth(splits(hh-1)+1:splits(hh));
        count = count+1;    
            else
        fp_renew{count} = pth(splits(hh-1)+1:end);    
            end
        end
        
    end
    else if length(splits)==1
    fp_renew{count} = pth(1:splits(1));
    count = count+1;
    fp_renew{count} = pth(splits(1)+1:end);   
        else
     fp_renew{count} = pth;       
        end
    end
    
    else
    fp_renew{count} = final_path{mm};
    end
    
    clear distance; 

    dur =1;
    
end
