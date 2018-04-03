function ap = ComputeAP(scores, labels)

[~, rank] = sort(scores,'descend');

count = 0;
pos = 0;
ap = 0;
for i = 1:length(scores)
    
    if labels(rank(i)) == 1 % pos
       pos = pos + 1;
       count = count + 1;
       ap = ap + pos/count;
    elseif labels(rank(i)) == 0 % neg
        count = count + 1;
    end
    
end

ap = ap / pos;