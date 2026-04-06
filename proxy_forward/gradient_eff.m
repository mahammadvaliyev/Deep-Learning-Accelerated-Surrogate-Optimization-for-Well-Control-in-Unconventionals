% clc;
% fclose('all');
% clear
rng(17)

tic
load('BHPs_physics.mat')
EURs_proxy=zeros(20,19);
BHPs_proxy=zeros(20,19);
parfor i=1:20
    [EURs_proxy(i,:),BHPs_proxy(i,:)]=forward_EUR_grad(i,BHPs_physics(i,:)); % f(x+dx) try and except
end
a=rand;
save(num2str(a),"a")

toc