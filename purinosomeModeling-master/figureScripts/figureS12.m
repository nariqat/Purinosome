%script to generate Figure S12
%CMJ 20160804
clear variables

figure('units','normalized','outerposition',[0 0 1 1])

M=100;

parameters=PduParams_MCP;
parameters.NCDE=parameters.NCDE*100;
parameters.NPQ=parameters.NPQ*100;
subplot(2,3,1)
sweep_paramsX2('kcA',-5,5,'Pout',-5,2,1,0,M,parameters);

parameters=PduParams_MCP;
parameters.NCDE=parameters.NCDE*100;
parameters.NPQ=parameters.NPQ*100;
parameters.jc=1;
subplot(2,3,2)
sweep_paramsX2('kcA',-5,5,'jc',-8,5,1,0,M,parameters);


parameters=PduParams_MCP;
parameters.NCDE=parameters.NCDE/100;
parameters.NPQ=parameters.NPQ/100;
subplot(2,3,4)
sweep_paramsX2('kcA',-5,5,'Pout',-5,2,1,0,M,parameters);

parameters=PduParams_MCP;
parameters.NCDE=parameters.NCDE/100;
parameters.NPQ=parameters.NPQ/100;
parameters.jc=1;
subplot(2,3,5)
sweep_paramsX2('kcA',-5,5,'jc',-8,5,1,0,M,parameters);