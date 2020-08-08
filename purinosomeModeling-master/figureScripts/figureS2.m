%script to generate Figure S2
%CMJ 20160804
clear variables

factor=10;

%MCP organization
figure('units','normalized','outerposition',[0 0 1 1])

%without active transport; Pext=55mM
subplot(2,3,1)
p = PduParams_MCP;
p.jc=0;
p.Pout=55e3;
flux_sensitivity(0,p,factor);
title('j_c=0 P_{out}=55mM')

%without active transport; Pext=0.5mM
subplot(2,3,2)
p = PduParams_MCP;
p.jc=0;
p.Pout=0.5e3;
flux_sensitivity(0,p,factor);
title('j_c=0 P_{out}=0.5mM')

%with active transport; Pext=55mM
subplot(2,3,4)
p = PduParams_MCP;
p.jc=1;
p.Pout=55e3;
flux_sensitivity(0,p,factor);
title('j_c=1 P_{out}=55mM')

%with active transport; Pext=0.5mM
subplot(2,3,5)
p = PduParams_MCP;
p.jc=1;
p.Pout=0.5e3;
flux_sensitivity(0,p,factor);
title('j_c=1 P_{out}=0.5mM')


%scaffold organization
figure('units','normalized','outerposition',[0 0 1 1])

%without active transport; Pext=55mM
subplot(2,3,1)
p = PduParams_MCP;
p.jc=0;
p.Pout=55e3;
p.kcA=1e3;
p.kcP=p.kcA;
flux_sensitivity(0,p,factor);
title('j_c=0 P_{out}=55mM')

%without active transport; Pext=0.5mM
subplot(2,3,2)
p = PduParams_MCP;
p.jc=0;
p.Pout=0.5e3;
p.kcA=1e3;
p.kcP=p.kcA;
flux_sensitivity(0,p,factor);
title('j_c=0 P_{out}=0.5mM')

%with active transport; Pext=55mM
subplot(2,3,4)
p = PduParams_MCP;
p.jc=1;
p.Pout=55e3;
p.kcA=1e3;
p.kcP=p.kcA;
flux_sensitivity(0,p,factor);
title('j_c=1 P_{out}=55mM')

%with active transport; Pext=0.5mM
subplot(2,3,5)
p = PduParams_MCP;
p.jc=1;
p.Pout=0.5e3;
p.kcA=1e3;
p.kcP=p.kcA;
flux_sensitivity(0,p,factor);
title('j_c=1 P_{out}=0.5mM')

