function CRR = get_recogniton_rate_dictionary_classificatin(grassSet)

% grassSet = grassSet1;

SR_lambda = 1e-1;    %sparse representation parameter
nAtoms = 128;        %size of the dictionary
dict_options.L = 20; %number of non-zero elements in OMP for dictionary learning

Solver_Flag = 1;
SR_lambda = 1e-1; 

trnIndex = find(grassSet.idx == 1);
tstIndex = find(grassSet.idx == 2);
trn.X = double(grassSet.X(:,:,trnIndex));
trn.y = grassSet.y(trnIndex);
tst.X = double(grassSet.X(:,:,tstIndex));
tst.y = grassSet.y(tstIndex);



addpath('iccv_ext_func');
[gSC_alpha,gSC_qX,gSC_D] = gsc_func(tst.X,trn.X,SR_lambda,Solver_Flag);
%Classification-SRC

y_hat = Classify_SRC(gSC_D,trn.y,gSC_alpha,gSC_qX);

CRR = sum(double(y_hat == tst.y))/length(tst.y);
fprintf('Correct recognition accuracy with a labeled dictionary : %.1f%%.\n',100*CRR);

