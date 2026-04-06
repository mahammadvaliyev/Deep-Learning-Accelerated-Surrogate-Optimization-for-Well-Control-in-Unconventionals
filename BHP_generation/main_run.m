%%
clear
clc
[BHPs_decr,d_decr]=gradient_eff();
plot(BHPs_decr_150')

%%

[BHPs_nondecr,d_nondecr]=gradient_eff1;
plot(BHPs_nondecr_150')


