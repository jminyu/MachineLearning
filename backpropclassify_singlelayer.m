maxepoch=10;
fprintf(1,'\nTraining discriminative model on MNIST by minimizing cross entropy error. \n');
fprintf(1,'60 batches of 1000 cases each. \n');

load mnistvhclassify

makebatches;
[numcases numdims numbatches]=size(batchdata);
N=numcases; 

%%%% PREINITIALIZE WEIGHTS OF THE DISCRIMINATIVE MODEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w1=[vishid; hidrecbiases];
w_class = 0.1*randn(size(w1,2)+1,10);
 

%%%%%%%%%% END OF PREINITIALIZATIO OF WEIGHTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

l1=size(w1,1)-1;
l4=size(w_class,1)-1;
l5=10; 
test_err=[];
train_err=[];


for epoch = 1:maxepoch

%%%%%%%%%%%%%%%%%%%% COMPUTE TRAINING MISCLASSIFICATION ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
err=0; 
err_cr=0;
counter=0;
[numcases numdims numbatches]=size(batchdata);
N=numcases;
 for batch = 1:numbatches
  data = [batchdata(:,:,batch)];
  target = [batchtargets(:,:,batch)];
  data = [data ones(N,1)];
  w1probs = 1./(1 + exp(-data*w1)); w1probs = [w1probs  ones(N,1)];
  targetout = exp(w1probs*w_class);
  targetout = targetout./repmat(sum(targetout,2),1,10);

  [I J]=max(targetout,[],2);
  [I1 J1]=max(target,[],2);
  counter=counter+length(find(J==J1));
  err_cr = err_cr- sum(sum( target(:,1:end).*log(targetout))) ;
 end
 train_err(epoch)=(numcases*numbatches-counter);
 train_crerr(epoch)=err_cr/numbatches;

%%%%%%%%%%%%%% END OF COMPUTING TRAINING MISCLASSIFICATION ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% COMPUTE TEST MISCLASSIFICATION ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
err=0;
err_cr=0;
counter=0;
[testnumcases testnumdims testnumbatches]=size(testbatchdata);
N=testnumcases;
for batch = 1:testnumbatches
  data = [testbatchdata(:,:,batch)];
  target = [testbatchtargets(:,:,batch)];
  data = [data ones(N,1)];
  w1probs = 1./(1 + exp(-data*w1)); w1probs = [w1probs  ones(N,1)];
  targetout = exp(w1probs*w_class);
  targetout = targetout./repmat(sum(targetout,2),1,10);

  [I J]=max(targetout,[],2);
  [I1 J1]=max(target,[],2);
  counter=counter+length(find(J==J1));
  err_cr = err_cr- sum(sum( target(:,1:end).*log(targetout))) ;
end
 test_err(epoch)=(testnumcases*testnumbatches-counter);
 test_crerr(epoch)=err_cr/testnumbatches;
 fprintf(1,'Before epoch %d Train # misclassified: %d (from %d). Test # misclassified: %d (from %d) \t \t \n',...
            epoch,train_err(epoch),numcases*numbatches,test_err(epoch),testnumcases*testnumbatches);

%%%%%%%%%%%%%% END OF COMPUTING TEST MISCLASSIFICATION ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 tt=0;
 for batch = 1:numbatches/10
 fprintf(1,'epoch %d batch %d\r',epoch,batch);

%%%%%%%%%%% COMBINE 10 MINIBATCHES INTO 1 LARGER MINIBATCH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 tt=tt+1; 
 data=[];
 targets=[]; 
 for kk=1:10
  data=[data 
        batchdata(:,:,(tt-1)*10+kk)]; 
  targets=[targets
        batchtargets(:,:,(tt-1)*10+kk)];
 end 

%%%%%%%%%%%%%%% PERFORM CONJUGATE GRADIENT WITH 3 LINESEARCHES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  max_iter=3;

  if epoch<6  % First update top-level weights holding other weights fixed. 
    N = size(data,1);
    XX = [data ones(N,1)];
    w1probs = 1./(1 + exp(-XX*w1)); w1probs = [w1probs  ones(N,1)];

    VV = [w_class(:)']';
    Dim = [l4; l5];
    [X, fX] = minimize(VV,'CG_CLASSIFY_INIT',max_iter,Dim,w1probs,targets);
    w_class = reshape(X,l4+1,l5);

  else
    VV = [w1(:)' w_class(:)']';
    Dim = [l1; l4; l5];
    [X, fX] = minimize(VV,'CG_CLASSIFY',max_iter,Dim,data,targets);

    w1 = reshape(X(1:(l1+1)*l2),l1+1,l2);
    xxx = (l1+1)*l2;
    w_class = reshape(X(xxx+1:xxx+(l4+1)*l5),l4+1,l5);

  end
%%%%%%%%%%%%%%% END OF CONJUGATE GRADIENT WITH 3 LINESEARCHES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 end

 save mnistclassify_weights w1 w_class
 save mnistclassify_error test_err test_crerr train_err train_crerr;

end



