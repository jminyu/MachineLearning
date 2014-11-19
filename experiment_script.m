%% Using Multi-Threading

matlabpool open 8;

%% experiment using MNIST and Single layer RBM and Back Propagation
%mnistclassify_singlelayer;

%% experiment using MNIST and normal RBM and Back Propagation
%mnistclassify;
%plot_image('normal_train_error.png',train_err_percentage,(1:max(size(train_err_percentage))),'Train error ratio','epoch','error');
%plot_image('normal_test_error.png',test_err_percentage,(1:max(size(test_err_percentage))),'Test error ratio','epoch','error');

%% experiment using MINST and RBM with random activation parameter(Alpha) and Back Propagation
%mnistclassify_randrbm;
%plot_image('random_train_error.png',train_err_percentage,(1:max(size(train_err_percentage))),'Train error ratio','epoch','error');
%plot_image('random_train_error.png',test_err_percentage,(1:max(size(test_err_percentage))),'Test error ratio','epoch','error');


%% experiment using MINST and RBM with random activation parameter(Alpha) and Back Propagation
mnistclassify_covrbm;
%plot_image('random_train_error.png',train_err_percentage,(1:max(size(train_err_percentage))),'Train error ratio','epoch','error');
%plot_image('random_train_error.png',test_err_percentage,(1:max(size(test_err_percentage))),'Test error ratio','epoch','error');


matlabpool close;


 

