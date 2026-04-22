function [] = plotboxplots(X, species, labels)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
x=2;
y=1;
for i=1:length(labels)
    subplot(2,x,y)
    boxplot(X(:,i), species)
    xlabel('Species')
    ylabel(labels(i))
    y=y+1;
end
end