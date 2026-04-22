function [X1, y1, X2, y2] = split_dataset(features, labels, ratio)

idx = (strcmp(labels(:), 'versicolor'));
[ft, lt] = pick(idx, features, labels);

indx = 1:1:floor(ratio * length(lt));
indx2 = floor(ratio * length(lt))+1:1:length(lt);
[X1a, y1a] = pick(indx, ft, lt);
[X2a, y2a] = pick(indx2, ft, lt);

idx = (strcmp(labels(:), 'setosa'));
[ft, lt] = pick(idx, features, labels);

indx = 1:1:floor(ratio * length(lt));
indx2 = floor(ratio * length(lt))+1:1:length(lt);
[X1b, y1b] = pick(indx, ft, lt);
[X2b, y2b] = pick(indx2, ft, lt);

idx = (strcmp(labels(:), 'virginica'));
[ft, lt] = pick(idx, features, labels);

indx = 1:1:floor(ratio * length(lt));
indx2 = floor(ratio * length(lt))+1:1:length(lt);
[X1c, y1c] = pick(indx, ft, lt);
[X2c, y2c] = pick(indx2, ft, lt);

X1 = [X1a;X1b;X1c];
y1 = [y1a;y1b;y1c];
X2 = [X2a;X2b;X2c];
y2 = [y2a;y2b;y2c];

end