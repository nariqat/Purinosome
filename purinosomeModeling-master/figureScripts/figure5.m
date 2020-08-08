%script to generate Figure 5
%CMJ 20160804
clear variables

figure('units','normalized','outerposition',[0 0 1 1])

M=100;

parameters=PduParams_MCP;
subplot(1,3,1)
sweep_paramsX2('kcA',-5,5,'Pout',-5,2,1,0,M,parameters);


parameters=PduParams_MCP;
parameters.jc=1;
subplot(1,3,2)
sweep_paramsX2('kcA',-5,5,'jc',-8,5,1,0,M,parameters);
