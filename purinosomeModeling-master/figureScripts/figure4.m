%script to generate Figure 4
%CMJ 20160804
add_paths %added

clear variables

figure('units','normalized','outerposition',[0 0 1 1])

M=50; % 50

sweepPerformance('Pout',-5,5,1,1,M,1,1);       % ('Pout',-5,2,1,1,M,1,1);