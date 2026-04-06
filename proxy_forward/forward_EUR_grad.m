function [EUR,BHP] = forward_EUR_grad(counter_var,bhp_realiz_j)

% % Initialize variables
% n_var=19;
% ir=1:n_var;
% 
% % Generate and write BHP input files
% bhp_realiz_j=[];
% for i=1:length(ir)
%     if (i==1)
%         bhp_time_i=5000;
%     else
%         bhp_time_i=(damp)*bhp_realiz_j(i-1)+ randn(1)*300;
%     end
%     bhp_time_i(bhp_time_i>5000)=5000;
%     bhp_time_i(bhp_time_i<500)=500;
%     bhp_realiz_j=[bhp_realiz_j bhp_time_i];
% end


bhp_realiz_j=reshape(bhp_realiz_j,[1,length(bhp_realiz_j)]);
bhp_realiz_j=(bhp_realiz_j-500)/(5000-500);

% make sure bhp is a row vector
modelfile = 'BHP_Opt_Proxy_AR_50.h5';
warning('off');
net = importKerasNetwork(modelfile);
prediction=predict(net,bhp_realiz_j);
prediction=prediction*(293938-30933)+30933;

% Store inputs and output in matrices
EUR=prediction;
BHP=bhp_realiz_j;

end