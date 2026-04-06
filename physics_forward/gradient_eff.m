clc;
fclose('all');
clear
rng(17)

tic

EURs_physics=zeros(20,19*2);
BHPs_physics=zeros(20,19);
damp=[1,1,0.95,0.95,0.9,0.9,0.85,0.85,0.8,0.8,0.75,0.75,0.7,0.7,0.65,0.65,0.6,0.6,0.55,0.55];
parfor i=1:20
    [EURs(i,:),BHPs(i,:)]=forward_EUR_grad(i,damp(i)); % f(x+dx) try and except
end
a=rand;
save(num2str(a),"a")

toc