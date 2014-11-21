%% Using Multi-Threading

matlabpool open 8;

%% experiment using MNIST and Single layer RBM and Back Propagation
mnistclassify;

%% experiment using MINST and RBM with random activation parameter(Alpha) and Back Propagation
mnistclassify_strategy1;
mnistclassify_strategy2;
mnistclassify_strategy3;
mnistclassify_strategy4;
mnistclassify_strategy5;
mnistclassify_strategy6;

matlabpool close;


 

