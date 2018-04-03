function keep_id = word_nms(x_cmb,thresh)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

        o1     = PropOver(x_cmb');      
        Ktr = zeros(size(x_cmb,1),size(x_cmb,1));
        Ktr(o1>thresh) = 1;
        keep_id = [];
        
        for ll=1:size(x_cmb,1)
            comp_id = find(Ktr(ll,:)==1);
            if length(comp_id)>1 
            keep_id = [keep_id;comp_id(2:end)'];
            end
        end

        keep_id = unique(keep_id);
