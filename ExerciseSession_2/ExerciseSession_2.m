clc;
clear;
close all;

load fisheriris;

%--------------------CATEGORICAL AND NUMERICAL DATA------------------------

unique(species);

species_num = ConvertNumArray(species);

% Verify Numerical Array has same values as Original Cell Array

assert(length(unique(ConvertNumArray(species))) == 3)

%Verify a Numerical Array value to the original cell array value

idx = 75;
categories = ConvertNumArray(species);
unique_categories = unique(species);
assert(species(idx) == string(unique_categories(categories(idx))))

%--------------------------DATA VISUALIZATION------------------------------

load fisheriris;
X = meas;
y = grp2idx(species);

% Function that outputs dimensions of each array
size(X);
size(y);

% Creation of labels vector and permutation index
labels = {'sepal length','sepal width','petal length','petal width'};
pairs = combnk(1:4,2);

for i=1:length(y)
    if i==y(1)
        Xsetosa(i) = meas(i);
    elseif i==y(2)
        Xversicolor(i) = meas(i);
    else
        Xvirginica(i) = meas(i);
    end
end

% Plot of the arrays
figure(1);
[Xsetosa, ~] = pick(species == "setosa", meas, species);
[Xversicolor, ~] = pick(species == "versicolor", meas, species);
[Xvirginica, ~] = pick(species == "virginica", meas, species);

plot([Xsetosa(:,1) Xversicolor(:,1) Xvirginica(:,1)],...
     [Xsetosa(:,2) Xversicolor(:,2) Xvirginica(:,2)], '.')
xlabel(labels{1})
ylabel(labels{2})

% Function that plot the 6 figures corresponding to visualization of each features taken 2 by 2
figure(2);
plot2dsamples(Xsetosa, Xversicolor, Xvirginica, pairs, labels);

% Histogram
figure(3);
histogram(Xsetosa(:,1), 'FaceAlpha', .7, 'FaceColor', 'b');
hold on
histogram(Xversicolor(:,1), 'FaceAlpha', .7, 'FaceColor', 'g');
hold on
histogram(Xvirginica(:,1), 'FaceAlpha', .7, 'FaceColor', 'r');
xlabel(labels{1})
ylabel("count")

% Function that plots the histograms of all the features
figure(4);
plothistogram(Xsetosa, Xversicolor, Xvirginica, labels);

% Boxplot
figure(5);
boxplot(X(:,1), species)
xlabel('Species')
ylabel(labels(1))

% Function that show the boxplots of all the features
figure(6);
plotboxplots(X, species, labels)






