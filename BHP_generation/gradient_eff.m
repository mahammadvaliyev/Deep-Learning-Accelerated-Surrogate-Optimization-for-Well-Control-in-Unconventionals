%function [EURs,BHPs] = gradient_eff()
function [BHPs,d ] = gradient_eff()

% BHPs=zeros(10,19);

% a=0.95;
% b=0.75;
a=750;
b=50;
d=[];
for i=1:150
    c=b+(a-b)/150*i;
    d=[d c];
end

% parfor i=1:10
parfor i=1:150
    [BHPs(i,:)]=forward_EUR_grad(i,d(i)); % f(x+dx) try and except
end

end

% [BHPs,d]=gradient_eff();
% plot(BHPs')

% a=0.95
% b=0.75;
% d=[];
% for i=1:50
%     c=b+(a-b)/50*i;
%     d=[d c];
% end
% plot(d')