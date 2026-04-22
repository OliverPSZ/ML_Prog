function [] = plothistogram(Xsetosa, Xversicolor, Xvirginica, labels)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
x=2;
y=1;
for i=1:length(labels)
    subplot(2,x,y)
    histogram(Xsetosa(:,i), 'FaceAlpha', .7, 'FaceColor', 'b'); 
    hold on
    histogram(Xversicolor(:,i), 'FaceAlpha', .7, 'FaceColor', 'g');
    hold on
    histogram(Xvirginica(:,i), 'FaceAlpha', .7, 'FaceColor', 'r');
    xlabel(labels{i})
    ylabel("count")
    y=y+1;
end
end