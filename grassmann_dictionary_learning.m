% Author:
% - Mehrtash Harandi (mehrtash.harandi at gmail dot com)
%
% This file is provided without any warranty of
% fitness for any purpose. You can redistribute
% this file and/or modify it under the terms of
% the GNU General Public License (GPL) as published
% by the Free Software Foundation, either version 3
% of the License or (at your option) any later version.

function D = grassmann_dictionary_learning(X,nAtoms,dict_options)

% X = trn.X ;

if (~isfield(dict_options,'L'))
    dict_options.L = 10;
end
if (~isfield(dict_options,'nIter'))
    dict_options.nIter = 5;
end
%initializing dictionary
% use the following two lines if you want to initialize the
% dictionary randomly.
% p = randperm(size(X,3));
% D = X(:,:,p(1:nAtoms));
fprintf('Initializing the dictionary using kmeans algorithm.\n');
D = kmeans_projection(X,nAtoms,5,false);

for tmpIter = 1:dict_options.nIter
    %sparse coding
    alpha = local_sparse_coding(X,D,dict_options.L);
    Dn = update_dict(X,D,alpha);
    if(tmpIter == 1)
        preCost = compute_dic_cost(X,D,alpha);
        fprintf('Initial cost -->%.3f\n',preCost);
    end
    postCost = compute_dic_cost(X,Dn,alpha);
    fprintf('Iter#%d: cost -->%.3f\n',tmpIter,postCost);
    D = Dn;
end
fprintf('-------\n');

end
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------


%--------------------------------------------------------------------------




%--------------------------------------------------------------------------


%--------------------------------------------------------------------------


%--------------------------------------------------------------------------



%--------------------------------------------------------------------------

