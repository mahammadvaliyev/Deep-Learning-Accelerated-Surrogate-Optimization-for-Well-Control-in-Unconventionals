%function [EUR,BHP] = forward_EUR_grad(counter_var)
function [BHP] = forward_EUR_grad(counter_var,rho)

bhp_realiz_j=[];
for i=1:19
    if (i==1)
        bhp_time_i=5000;
    else
        %bhp_time_i=rho*bhp_realiz_j(i-1)+ randn(1)*300;
%         bhp_time_i=rho*bhp_realiz_j(i-1);
        bhp_time_i=5000- rho*(i-1);
    end
    bhp_time_i(bhp_time_i>5000)=5000;
    bhp_time_i(bhp_time_i<500)=500;
    bhp_realiz_j=[bhp_realiz_j bhp_time_i];
end

BHP=bhp_realiz_j;

end