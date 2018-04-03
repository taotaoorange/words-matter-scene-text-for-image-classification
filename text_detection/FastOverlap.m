function o1_tmp = FastOverlap(x_cmb)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************
   
      for ll =1:1

           x1_smaller = zeros(size(x_cmb,2),1);
           x2_smaller = zeros(size(x_cmb,2),1);
           y1_smaller = zeros(size(x_cmb,2),1);
           y2_smaller = zeros(size(x_cmb,2),1);

           x1_smaller(find(x_cmb(1,:) <= x_cmb(1,ll)))=1;  
           y1_smaller(find(x_cmb(2,:) <= x_cmb(2,ll)))=1;  
           x2_smaller(find(x_cmb(3,:) <= x_cmb(3,ll)))=1;  
           y2_smaller(find(x_cmb(4,:) <= x_cmb(4,ll)))=1;   

           xx1                      = zeros(size(x_cmb,2),1);
           xx1(find(x1_smaller==0)) = x_cmb(1,find(x1_smaller==0));
           xx1(find(x1_smaller==1)) = x_cmb(1,ll);

           yy1                      = zeros(size(x_cmb,2),1);
           yy1(find(y1_smaller==0)) = x_cmb(2,find(y1_smaller==0));
           yy1(find(y1_smaller==1)) = x_cmb(2,ll);

           xx2                      = zeros(size(x_cmb,2),1);
           xx2(find(x2_smaller==1)) = x_cmb(3,find(x2_smaller==1));
           xx2(find(x2_smaller==0)) = x_cmb(3,ll);

           yy2                      = zeros(size(x_cmb,2),1);
           yy2(find(y2_smaller==1)) = x_cmb(4,find(y2_smaller==1));
           yy2(find(y2_smaller==0)) = x_cmb(4,ll);

           xx_uni1                  = zeros(size(x_cmb,2),1);
           xx_uni1(find(x1_smaller==1)) = x_cmb(1,find(x1_smaller==1));
           xx_uni1(find(x1_smaller==0)) = x_cmb(1,ll);

           yy_uni1                  = zeros(size(x_cmb,2),1);
           yy_uni1(find(y1_smaller==1)) = x_cmb(2,find(y1_smaller==1));
           yy_uni1(find(y1_smaller==0)) = x_cmb(2,ll);

           xx_uni2                      = zeros(size(x_cmb,2),1);
           xx_uni2(find(x2_smaller==0)) = x_cmb(3,find(x2_smaller==0));
           xx_uni2(find(x2_smaller==1)) = x_cmb(3,ll);

           yy_uni2                      = zeros(size(x_cmb,2),1);
           yy_uni2(find(y2_smaller==0)) = x_cmb(4,find(y2_smaller==0));
           yy_uni2(find(y2_smaller==1)) = x_cmb(4,ll);

           w(1:length(yy_uni2)) =0; w = w';
           h(1:length(yy_uni2)) =0; h = h';
           
           w_uni(1:length(yy_uni2)) =0; w_uni = w_uni';
           h_uni(1:length(yy_uni2)) =0; h_uni = h_uni';
           o1_tmp(1:length(yy_uni2)) =0; o1_tmp = o1_tmp';
           
           w(ll:end) = xx2(ll:end)-xx1(ll:end)+1; 
           h(ll:end) = yy2(ll:end)-yy1(ll:end)+1;

           w_uni(ll:end) = xx_uni2(ll:end)-xx_uni1(ll:end)+1; 
           h_uni(ll:end) = yy_uni2(ll:end)-yy_uni1(ll:end)+1;

           o1_tmp(ll:end) = w(ll:end).*h(ll:end)./w_uni(ll:end)./h_uni(ll:end);

           o1_tmp(find(w<=0))=0;
           o1_tmp(find(h<=0))=0;

      end 
 

           


