function [BW_CDF] = get_eav_threshold_only(I,Significance_CDF,Significance_PDF)   

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************


    X = reshape(I , 1 , size(I,1) * size(I,2)); 
    Parameters = evfit(double(X));
    mu = Parameters(1,1);
    sigma = Parameters(1,2);
    CDF = evcdf([1:256],mu,sigma);
    CDF_100 = CDF*100;

    
    
    if Significance_CDF == 100
    EXTREAME_THRESH_CDF = max(find(CDF_100 <98 ));
    else
    EXTREAME_THRESH_CDF = min(find(CDF_100 >Significance_CDF ));
    end
    if isempty ( EXTREAME_THRESH_CDF )
       EXTREAME_THRESH_CDF = max(find(CDF_100 >max(CDF_100)-20)); 
    end

    BW_CDF = im2bw(I,(EXTREAME_THRESH_CDF/255.0));
    
    %   fprintf('mu %1.2f \t Std %1.2f \t Limit %1.2f \t PDF TH %1.2f \t CDF TH %1.2f \t \n ',mu,sigma,sigma,EXTREAME_THRESH_PDF,EXTREAME_THRESH_CDF);

end