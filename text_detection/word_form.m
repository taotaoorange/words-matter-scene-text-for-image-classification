function conns = word_form(bw1,test_slope,test_radius,org_im)

%   *****************************************
%   LAST VERSION 29.03.2018
%	Copyright by Sezer Karaoglu
%   *****************************************

conns = {};

for i = 1:length(bw1)
    
		conns{i}=[i];
		
		cx1 = bw1(i).Centroid(1);
		cy1 = bw1(i).Centroid(2);
		xx1 = bw1(i).BoundingBox(1);
		yy1 = bw1(i).BoundingBox(2);
		ww1 = bw1(i).BoundingBox(3);
		hh1 = bw1(i).BoundingBox(4);
		
        %aspect ratio
		ar1 = ww1/hh1;
		
		%plot the circle 
		r = test_radius*max(ww1,hh1);
		
		for j = i:length(bw1)
			cx2 = bw1(j).Centroid(1);
			cy2 = bw1(j).Centroid(2);
			xx2 = bw1(j).BoundingBox(1);
			yy2 = bw1(j).BoundingBox(2);
			ww2 = bw1(j).BoundingBox(3);
			hh2 = bw1(j).BoundingBox(4);
			%aspect ratio
			ar2 = ww2/hh2;
			%slope (y2-y1)/(x2-x1)
			slope = (cy2-cy1)/(cx2-cx1);
			%plot(cx2,cy2,'g.');
			
			%calculate overlap
			bi=[max(xx1,xx2) ; max(yy1,yy2) ; min(xx1+ww1,xx2+ww2) ; min(yy1+hh1,yy2+hh2)];              
            iw=bi(3)-bi(1)+1;
            ih=bi(4)-bi(2)+1;
			ov =0;
			if iw>0 && ih>0
                % compute overlap as area of intersection / area of union
                ua =(ww1+1)*(hh1+1)+(ww2+1)*(hh2+1)-iw*ih;
                ov =iw*ih/ua;
            end
			
			%(ar1>0.5*ar2) && (ar1<1.5*ar2) && ...		%similar aspect ratio
			
%             imshow(org_im,[]);
%             rectangle('Position',[xx1 yy1 ww1 hh1], 'LineWidth',1, 'EdgeColor',[0 0 1]);
%             rectangle('Position',[xx2 yy2 ww2 hh2], 'LineWidth',1, 'EdgeColor',[1 0 0]);
            
			if (((cx2-cx1)^2 + (cy2-cy1)^2) < r^2) && ... 	%in a circle around
				(cx2>cx1) && ...							%left to right				
				(hh1>0.5*hh2) && (hh1<2*hh2) && ...			%similar height	
				slope < test_slope && slope > -test_slope && ...			%-1 < slope < 1
				ov < 0.10 && ...								%overlap between connection less than 10%
			    (yy1+hh1)>(yy2+hh2/2) && ...
                (yy2+hh2)>(yy1+hh1/2)
            
            
				%plot(cx2,cy2,'g.');

% 				xx2 = bw1(j).BoundingBox(1);
% 				yy2 = bw1(j).BoundingBox(2);
% 				ww2 = bw1(j).BoundingBox(3);
% 				hh2 = bw1(j).BoundingBox(4);
				
%                 imshow(org_im,[]);
%                 rectangle('Position',[xx1 yy1 ww1 hh1], 'LineWidth',1, 'EdgeColor',[0 0 1]);
% 				rectangle('Position',[xx2 yy2 ww2 hh2], 'LineWidth',1, 'EdgeColor',[1 0 0]);
                 
				conns{i}=[conns{i} j];
				%pause;
            end
        end
end