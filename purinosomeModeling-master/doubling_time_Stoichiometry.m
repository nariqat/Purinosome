function [] = doubling_time_Stoichiometry(equalPermSwitch,N)
% predict the cell doubling time as a function of a model parameter

% add paths
add_paths
changeplot

% define baseline parameters
p = PduParams_MCP;

% Define parameter sweeps in cell array
numberofsims= N;

Ntotal=p.NCDE+p.NPQ;
fracCDE=p.NCDE/Ntotal;

%sweep Ntotal first
sweep = {'',logspace(-2,3,numberofsims)};
startValue=Ntotal;
startValue2=p.q; % added

for ii = 1:length(sweep{1,2})
   
    set(p, 'NCDE',sweep{1,2}(ii)*startValue*fracCDE);
    set(p, 'NPQ',sweep{1,2}(ii)*startValue*(1-fracCDE));
    set(p,'q',sweep{1,2}(ii)*startValue2); % added

    if equalPermSwitch
        p.kcP = p.kcA; %keep kcX the same
    end

    % run the simulation
    res = ConstantMCPAnalyticalSolution(p);
    
    Pfull(ii)=res.p_full_uM/1000;
    Afull(ii)=res.a_full_uM/1000;
    Psatsat(ii)=res.p_satsat_uM/1000;
    Punsatunsat(ii)=res.p_unsatunsat_uM/1000;
    Aunsatunsat(ii)=res.a_unsatunsat_uM/1000;
    Asatunsat(ii)=res.a_satunsat_uM/1000;
    Pcyto(ii)=res.p_cyto_uM/1000;
    Acyto(ii)=res.a_cyto_uM/1000;
    rPQ(ii)=p.VPQ*Afull(ii)*1000/(p.KPQ+Afull(ii)*1000)*(p.VMCP/1000); %changed
    flux(ii)=rPQ(ii)/(10^6)*3600;  %changed
    tDouble(ii)=1.99*(10^-11)/flux(ii); %changed
    
end

% plot results
subplot(1,3,1)
loglog(sweep{1,2},tDouble,'-','Color',[43 172 226]./256,'LineWidth',2)
hold on
fill([sweep{1,2}(1), sweep{1,2}(end), sweep{1,2}(end), sweep{1,2}(1)],[10, 10, 5, 5],[0.7 0.7 0.7],'EdgeColor','none')
plot(sweep{1,2},tDouble,'-','Color',[43 172 226]./256,'LineWidth',2)

xlabel(['parameter: Ntotal' sweep{1,1}])
ylabel('Doubling Time (hrs)')
xlim([sweep{1,2}(1) sweep{1,2}(end)])
ylim([1 10^4])
line([1 1],ylim,'Color','k','LineStyle',':','LineWidth',1.5)
ax=gca;
set(ax,'FontSize',12)
set(ax ,'Layer', 'Top')
ax.XTick=(sweep{1,2}(1:round(numberofsims/5):numberofsims));
for i=1:round(numberofsims/5):numberofsims
    labelString=num2str(startValue.*sweep{1,2}(i),'%1.2e');
    xLabels{(i-1)/round(numberofsims/5)+1}=[labelString(1:3) 'x10^{', labelString(6:end), '}'];
end
ax.XTickLabel=xLabels;
ax.XTickLabelRotation = 45;
axis square

%then fracCDE
% define baseline parameters
p = PduParams_MCP;

Ntotal=p.NCDE+p.NPQ;
fracCDE=p.NCDE/Ntotal;

sweep = {'',linspace(0,1,numberofsims)};

for ii = 1:length(sweep{1,2})
   
    set(p, 'NCDE',(1-sweep{1,2}(ii))*Ntotal);
    set(p, 'NPQ',sweep{1,2}(ii)*Ntotal);

    if equalPermSwitch
        p.kcP = p.kcA; %keep kcX the same
    end

    % run the simulation
    res = ConstantMCPAnalyticalSolution(p);
    
    Pfull(ii)=res.p_full_uM/1000;
    Afull(ii)=res.a_full_uM/1000;
    Psatsat(ii)=res.p_satsat_uM/1000;
    Punsatunsat(ii)=res.p_unsatunsat_uM/1000;
    Aunsatunsat(ii)=res.a_unsatunsat_uM/1000;
    Asatunsat(ii)=res.a_satunsat_uM/1000;
    Pcyto(ii)=res.p_cyto_uM/1000;
    Acyto(ii)=res.a_cyto_uM/1000;
    rPQ(ii)=2*p.VPQ*Afull(ii)*1000/(p.KPQ+Afull(ii)*1000)*(p.VMCP/1000);
    flux(ii)=rPQ(ii)/(10^6)*(58.1*3600)/2;
    tDouble(ii)=0.3*10^-12/flux(ii);
    
end

% plot results
subplot(1,3,2)
semilogy(sweep{1,2},tDouble,'-','Color',[43 172 226]./256,'LineWidth',2)
hold on
fill([sweep{1,2}(1), sweep{1,2}(end), sweep{1,2}(end), sweep{1,2}(1)],[10, 10, 5, 5],[0.7 0.7 0.7],'EdgeColor','none')
plot(sweep{1,2},tDouble,'-','Color',[43 172 226]./256,'LineWidth',2)

xlabel(['parameter: fracPQ' sweep{1,1}])
ylabel('Doubling Time (hrs)')
xlim([0 1])   
ylim([1 10^4])
line([1-fracCDE 1-fracCDE],ylim,'Color','k','LineStyle',':','LineWidth',1.5)
ax=gca;
set(ax,'FontSize',12)
set(ax ,'Layer', 'Top')
% ax.XTick=(sweep{1,2}(1:round(numberofsims/5):numberofsims));
% for i=1:round(numberofsims/5):numberofsims
%     labelString=num2str(startValue.*sweep{1,2}(i),'%1.2e');
%     xLabels{(i-1)/round(numberofsims/5)+1}=[labelString(1:3) 'x10^{', labelString(6:end), '}'];
% end
% ax.XTickLabel=xLabels;
% ax.XTickLabelRotation = 45;
axis square
    