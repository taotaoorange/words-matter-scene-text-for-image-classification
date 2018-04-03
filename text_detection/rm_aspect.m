function rm_asp = rm_aspect(data,orgIM)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

for hh =1 :length(data)
    asp(hh) = data(hh).BoundingBox(3)./data(hh).BoundingBox(4);
    aspV(hh) = data(hh).BoundingBox(4)./data(hh).BoundingBox(3);
end



rm_asp1 = find(asp>10);
rm_asp2 = find(aspV>10);
rm_asp = [rm_asp1 rm_asp2];