clc;
fclose('all');
clear
rng(17)


EURs09=zeros(200,19*2);
BHPs09=zeros(200,19);

for i=1:1
    tic
    [EURs09(10*(i-1)+1:10*i,:),BHPs09(10*(i-1)+1:10*i,:)]=gradient_eff();
    disp('Iteration')
    disp(i)
    toc
end
