clc;
clear;
close all;

%-----------------LOADING DATASET-----------------

load fisheriris

%--------------DISPLAYING THE DATASET-------------

meas;
%disp(meas);
%disp(species);

%-----------------ACCESSING DATA------------------

% Single element of dataset
[X, y] = pick(10, meas, species);

% Several elements of dataset
[X, y] = pick([1,2,3,4], meas, species);

% Store the whole dataset in X and y
[X, y] = pick([1:size(species)], meas, species);

% Store each elements of odd indexes
idx = (repmat(1:2,1,75) == 1);
[X, y] = pick(idx, meas, species);

% All the flowers of sepal width, i.e. second feature of meas, greater than 3
idx = (meas(:,2) > 3);
[X, y] = pick(idx, meas, species);

% All the versicolor flowers
idx = (strcmp(species(:), 'versicolor'));
[X, y] = pick(idx, meas, species);

%-----------SORTING AND SHUFFLING DATA--------------- 

% Add column to keep track of changes
meas = [[1:length(meas)].', meas];

% Generate a random array of indexes
idx  = randperm(length(meas));

% Shuffle meas and species
X = meas(idx,:);
y = species(idx,:);

% Put them back in order
[X,I] = sortrows(X);
y=y(I);

% Check if everything is as before
(X-meas) < 1e-4;

%-------------------DATA SLICING-------------------

ratio = 0.5;
[X1, y1, X2, y2] = split_dataset(meas, species, ratio);

length(X1) == ratio * length(meas);
(sort(meas) - sort([X1;X2])) < 1e-4;

assert(length(X1) == ratio * length(meas))
%assert(all((sort(meas) - sort([X1;X2]) < 1e-4)))

assert(sum(y1 == "setosa") == ratio * length(meas) / 3)
