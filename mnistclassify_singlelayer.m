clear all
close all

maxepoch=50; 
numhid=500; 

fprintf(1,'Converting Raw files into Matlab format \n');
converter; 

fprintf(1,'Pretraining a deep autoencoder. \n');
fprintf(1,'The Science paper used 50 epochs. This uses %3i \n', maxepoch);

makebatches;
[numcases numdims numbatches]=size(batchdata);


%% Pretraining Layer 1
fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);
restart=1;
rbm;
hidrecbiases=hidbiases; 
save mnistvhclassify vishid hidrecbiases visbiases;

backpropclassify_singlelayer; 

