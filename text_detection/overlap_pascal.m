function ov =  overlap_pascal(x_cmb)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

bbgt=x_cmb(:,1);
 
for ll=1:size(x_cmb,2)
bb = x_cmb(:,ll);                
bi=[max(bb(1),bbgt(1)) ; max(bb(2),bbgt(2)) ; min(bb(3),bbgt(3)) ; min(bb(4),bbgt(4))];
                
iw=bi(3)-bi(1)+1;
ih=bi(4)-bi(2)+1;
                
                if iw>0 && ih>0
                    % compute overlap as area of intersection / area of union
                    ua =(bb(3)-bb(1)+1)*(bb(4)-bb(2)+1)+(bbgt(3)-bbgt(1)+1)*(bbgt(4)-bbgt(2)+1)-iw*ih;
                    ov(ll) =iw*ih/ua;
                else
                    ov(ll) =0;
                    
                end
end