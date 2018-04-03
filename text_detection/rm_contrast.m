function rm_id = rm_contrast(data, img)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

if size(img,3)>1
img = double(rgb2gray(img));
else
img = double(img);
end
    
Bx1=gDer(img,1.6,1,0);    
By1=gDer(img,1.6,0,1);

cont_img = sqrt(Bx1.^2+By1.^2+Bx1.*By1);

rm_id=[];


for i=1:length(data)
    
coords = data(i).BoundingBox;

if ceil(coords(1))-coords(3)/10>1
coords1(1) = ceil(coords(1))-coords(3)/10;
else
coords1(1) = coords(1);    
end

if ceil(coords(2))-coords(4)/10>1
coords1(2) = ceil(coords(2))-coords(4)/10;
else
coords1(2) = coords(2);   
end

if ceil(coords(1))+coords(3)+coords(3)/10<size(img,2)
coords1(3) = ceil(coords(3))+coords(3)/10;
else
coords1(3) = coords(3);
end

if ceil(coords(2))+coords(4)+coords(4)/10<size(img,1)
coords1(4) = ceil(coords(4))+coords(4)/10;
else
coords1(4) = coords(4);    
end

cntrst  = cont_img(ceil(coords(2)):floor(coords(2)+coords(4)),ceil(coords(1)):floor(coords(1)+coords(3)));
cntrst1 = cont_img(ceil(coords1(2)):floor(coords1(2)+coords1(4)),ceil(coords1(1)):floor(coords1(1)+coords1(3)));
    
mean_con = mean2(cntrst);
mean_con1 = mean2(cntrst1);

% rectangle('Position',[coords(1) coords(2) coords(3) coords(4)], 'LineWidth',1, 'EdgeColor',[1 1 0]);

if (mean_con+0.5) < mean_con1
   rm_id = [rm_id;i];
end




clear coords1 coords

end

end

function [H]= gDer(f,sigma, iorder,jorder)
%Initialize the filter
break_off_sigma = 3.;
filtersize = break_off_sigma*sigma;
x=-filtersize:1:filtersize;
Gauss=1/(sqrt(2 * pi) * sigma)* exp((x.^2)/(-2 * sigma * sigma) );

switch(iorder)
case 0
    Gx= Gauss/sum(Gauss);
case 1
    Gx  =  -(x/sigma^2).*Gauss;
    Gx  =  Gx./(sum(sum(x.*Gx)));
case 2
    Gx = (x.^2/sigma^4-1/sigma^2).*Gauss;
    Gx = Gx-sum(Gx)/size(x,2);
    Gx = Gx/sum(0.5*x.*x.*Gx);
end
H = filter2(Gx,f);

switch(jorder)
case 0
    Gy= Gauss/sum(Gauss);
case 1
    Gy  =  -(x/sigma^2).*Gauss;
    Gy  =  Gy./(sum(sum(x.*Gy)));
case 2
    Gy = (x.^2/sigma^4-1/sigma^2).*Gauss;
    Gy = Gy-sum(Gy)/size(x,2);
    Gy = Gy/sum(0.5*x.*x.*Gy);
end
	H = filter2(Gy',H);
end