function [] = plot2dsamples(Xsetosa, Xversicolor, Xvirginica, pairs, labels)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x=3;
y=1;
for i=1:size(pairs,1)
    subplot(2,x,y)
    plot([Xsetosa(:,pairs(i,1)) Xversicolor(:,pairs(i,1)) Xvirginica(:,pairs(i,1))],...
         [Xsetosa(:,pairs(i,2)) Xversicolor(:,pairs(i,2)) Xvirginica(:,pairs(i,2))], '.')
    xlabel(labels{pairs(i,1)})
    ylabel(labels{pairs(i,2)})
    y=y+1;
end

end