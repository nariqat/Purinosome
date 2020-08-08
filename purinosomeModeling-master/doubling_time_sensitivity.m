function [] = doubling_time_sensitivity(equalPermSwitch,param,factor)
% predict the change in cell doubling time as a function of a perturbation in each model parameter

% add paths
add_paths
changeplot

% define baseline parameters
p = param;

% Define parameter sweeps in cell array
params= {'jc','kcA','kcP','kmA','kmP','Pout','kcatCDE','NCDE','KCDE','kcatPQ','NPQ','KPQ'};

% Define baseline doubling time
res = ConstantMCPAnalyticalSolution(p);

Afull=res.a_full_uM/1000;
rPQ = p.VPQ*Afull*1000/(p.KPQ+Afull*1000)*(p.VMCP/1000);    % rPQ=2*p.VPQ*Afull*1000/(p.KPQ+Afull*1000)*(p.VMCP/1000);
flux = rPQ/(10^6)*3600; % flux=rPQ/(10^6)*(58.1*3600)/2;

baselinetDouble=0.3*10^-12/flux;

% increase params by X%
for ii = 1:length(params)
    
    startValue=get(p,params{ii});
    set(p, params{ii},(1+factor/100)*startValue);
    
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
    rPQ(ii)=p.VPQ*Afull(ii)*1000/(p.KPQ+Afull(ii)*1000)*(p.VMCP/1000);    % rPQ(ii)=2*p.VPQ*Afull(ii)*1000/(p.KPQ+Afull(ii)*1000)*(p.VMCP/1000);
    flux(ii)=rPQ(ii)/(10^6)*3600;    % flux(ii)=rPQ(ii)/(10^6)*(58.1*3600)/2;
    tDouble1(ii)=1.99*(10^-11)/flux(ii);    % tDouble1(ii)=0.3*10^-12/flux(ii);
    
    set(p, params{ii},startValue);
    
end

tDouble1=(tDouble1./baselinetDouble);

% define baseline parameters
p = param;

% decrease params by X%
for ii = 1:length(params)
    
    startValue=get(p,params{ii});
    set(p, params{ii},(1-factor/100)*startValue);
    
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
        % rPQ(ii)=2*p.VPQ*Afull(ii)*1000/(p.KPQ+Afull(ii)*1000)*(p.VMCP/1000);
        % flux(ii)=rPQ(ii)/(10^6)*(58.1*3600)/2;
        % tDouble2(ii)=0.3*10^-12/flux(ii);
    
end

tDouble2=(tDouble2./baselinetDouble);

%merge results
tDouble(1:2:2*length(tDouble1))=tDouble1;
tDouble(2:2:2*length(tDouble2))=tDouble2;

% plot results
hold on
fill([0, 1+length(params), 1+length(params), 0],[1.1, 1.1, 0.9, 0.9],[0.7 0.7 0.7],'EdgeColor','none')
ax=bar([tDouble1' tDouble2'],0.8);
set(gca,'YScale','log')
ax(1).FaceColor=[43 172 226]./256;
ax(2).FaceColor=[248 149 33]./256;
set(gca,'XTick',1:length(params))
set(gca,'XTickLabel',params)
set(gca,'XTickLabelRotation',45);
set(gca,'FontSize',12)
set(gca ,'Layer', 'Top')
ylabel('Fold Change in Doubling Time')
line([0,1+length(params)],[1 1],'LineStyle','--','Color','r','LineWidth',2)
ylim([0.75, 1.5])
xlim([0,1+length(params)])

axis square

leg1=[sprintf('Parameter increased by %i',factor) '%'];
leg2=[sprintf('Parameter decreased by %i',factor) '%'];
legend('10% change in doubling time',leg1,leg2,'Location','Northwest')


    