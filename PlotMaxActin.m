function PlotMaxActin(specif,label,col,datapath,SaveSpecif)
%% INIT

warning('off','all')

close all
set(0,'DefaultFigureWindowStyle','docked')
set(0,'DefaultTextInterpreter','none');
set(0,'DefaultAxesFontSize',30)

ff = [datapath filesep 'Figures' filesep 'Plots'];

mkdir(ff)

ns = length(specif);

MedInts = cell(1,ns);
MedIntNorms = cell(1,ns);
FluctInts = cell(1,ns);
FluctIntNorms = cell(1,ns);
BckGrnd = cell(1,ns);
Spatialvar = cell(1,ns);


%% Load files


if length(col) ~= ns || length(label) ~= ns
    error('Number of conditions, color and labels must be the same')
end

for ks = 1:length(specif)
    
    load([datapath filesep 'MA_' specif{ks}])
    
    
    MedInts{ks} = AllMeds;
    MedIntNorms{ks} = AllMedNorms;
    FluctInts{ks} = AllFlucts(AllFlucts>6);
    FluctIntNorms{ks} = AllFluctNorms;
    BckGrnd{ks} = AllBckGrnd;
    Spatialvar{ks} = AllSpatialVar;
    
end


%% Plots

% Cell background intensities
 figure
    hold on
    
    set(0,'DefaultLineMarkerSize',8);
    plotSpread_V(BckGrnd,'distributionMarkers',{'o'},'distributionColors',col ...
        ,'xValues',1:ns,'xNames',label,'spreadWidth',0.9);
    
    for ks = 1:ns
        plot([ks-0.38 ks+0.38],[nanmedian(BckGrnd{ks}) nanmedian(BckGrnd{ks})],'k--','linewidth', 3)
    end
    
    ypos = prctile(BckGrnd{1},95); % for *** positioning
    
    % statistic comparison
    for ks = 1:ns-1 % ks = 1:1 for comparing everything to the first condition only
        for kkt = ks+1:ns
            pC = ranksum(BckGrnd{ks},BckGrnd{kkt});
            
            if pC < 0.001
                
                txtsup = ['p < 0.001'];
                
            else
                
                txtsup = ['p = ' num2str(pC,'%.3f')];
                
            end
            
            if 5/100 > pC && pC > 1/100
                txtC = ['*  ' txtsup]  ;
                plotsig = 1;
            elseif 1/100 > pC && pC > 1/1000
                txtC = ['**  ' txtsup];
                plotsig = 1;
            elseif 1/1000 > pC
                txtC = ['***  ' txtsup];
                plotsig = 1;
            else
                txtC = ['NS  ' txtsup];
                plotsig = 0;
            end
            
            if plotsig
                
                line([ks+0.1 kkt-0.1],[ypos ypos],'color','k', 'linewidth', 1.3);
                text((ks+kkt)/2,ypos + 4,txtC,'HorizontalAlignment','center','fontsize',11)
                
                ypos = ypos + 10;
                
            end
            
        end
    end
        
    ylim([0 ypos+10])
    ylabel('Cell intensity background (a.u.)','interpreter','latex','fontsize',30)
    
    % save figure
    fig = gcf;
    saveas(fig,[ff filesep 'Bckgrnds_' SaveSpecif '.fig'],'fig')
    saveas(fig,[ff filesep 'Bckgrnds_' SaveSpecif '.png'],'png')
    
    
% Spatial Variations
 figure
    hold on
    
    set(0,'DefaultLineMarkerSize',8);
    plotSpread_V(Spatialvar,'distributionMarkers',{'o'},'distributionColors',col ...
        ,'xValues',1:ns,'xNames',label,'spreadWidth',0.9);
    
    for ks = 1:ns
        plot([ks-0.38 ks+0.38],[nanmedian(Spatialvar{ks}) nanmedian(Spatialvar{ks})],'k--','linewidth', 3)
    end
    
    ypos = prctile(Spatialvar{1},95); % for *** positioning
    
    % statistic comparison
    for ks = 1:ns-1 % ks = 1:1 for comparing everything to the first condition only
        for kkt = ks+1:ns
            pC = ranksum(Spatialvar{ks},Spatialvar{kkt});
            
            if pC < 0.001
                
                txtsup = ['p < 0.001'];
                
            else
                
                txtsup = ['p = ' num2str(pC,'%.3f')];
                
            end
            
            if 5/100 > pC && pC > 1/100
                txtC = ['*  ' txtsup]  ;
                plotsig = 1;
            elseif 1/100 > pC && pC > 1/1000
                txtC = ['**  ' txtsup];
                plotsig = 1;
            elseif 1/1000 > pC
                txtC = ['***  ' txtsup];
                plotsig = 1;
            else
                txtC = ['NS  ' txtsup];
                plotsig = 0;
            end
            
            if plotsig
                
                line([ks+0.1 kkt-0.1],[ypos ypos],'color','k', 'linewidth', 1.3);
                text((ks+kkt)/2,ypos + 4,txtC,'HorizontalAlignment','center','fontsize',11)
                
                ypos = ypos + 6;
                
            end
            
        end
    end
        
    ylim([0 ypos+15])
    ylabel('Spatial intensity Variation (a.u.)','interpreter','latex','fontsize',30)
    
    % save figure
    fig = gcf;
    saveas(fig,[ff filesep 'Spatialvar_' SaveSpecif '.fig'],'fig')
    saveas(fig,[ff filesep 'Spatialvar_' SaveSpecif '.png'],'png')


% Intensities fluctuations
 figure
    hold on
    
    set(0,'DefaultLineMarkerSize',8);
    plotSpread_V(FluctInts,'distributionMarkers',{'o'},'distributionColors',col ...
        ,'xValues',1:ns,'xNames',label,'spreadWidth',0.9);
    
    for ks = 1:ns
        plot([ks-0.38 ks+0.38],[nanmedian(FluctInts{ks}) nanmedian(FluctInts{ks})],'k--','linewidth', 3)
    end
    
    ypos = prctile(FluctInts{1},98); % for *** positioning
    
    % statistic comparison
    for ks = 1:ns-1 % ks = 1:1 for comparing everything to the first condition only
        for kkt = ks+1:ns
            pC = ranksum(FluctInts{ks},FluctInts{kkt});
            
             if pC < 0.001
                
                txtsup = ['p < 0.001'];
                
            else
                
                txtsup = ['p = ' num2str(pC,'%.3f')];
                
            end
            
            if 5/100 > pC && pC > 1/100
                txtC = ['*  ' txtsup]  ;
                plotsig = 1;
            elseif 1/100 > pC && pC > 1/1000
                txtC = ['**  ' txtsup];
                plotsig = 1;
            elseif 1/1000 > pC
                txtC = ['***  ' txtsup];
                plotsig = 1;
            else
                txtC = ['NS  ' txtsup];
                plotsig = 0;
            end
            
            if plotsig
                
                line([ks+0.1 kkt-0.1],[ypos ypos],'color','k', 'linewidth', 1.3);
                text((ks+kkt)/2,ypos + 9,txtC,'HorizontalAlignment','center','fontsize',11)
                
                ypos = ypos + 15;
                
            end
            
        end
    end
        
    ylim([0 ypos+15])
    ylabel('Intensity fluctuations (a.u.)','interpreter','latex','fontsize',30)
    
    % save figure
    fig = gcf;
    saveas(fig,[ff filesep 'FluctInts_' SaveSpecif '.fig'],'fig')
    saveas(fig,[ff filesep 'FluctInts_' SaveSpecif '.png'],'png')



% Normalized intensities nanmedian
 figure
    hold on
    
    set(0,'DefaultLineMarkerSize',8);
    plotSpread_V(MedIntNorms,'distributionMarkers',{'o'},'distributionColors',col ...
        ,'xValues',1:ns,'xNames',label,'spreadWidth',0.9);
    
    for ks = 1:ns
        plot([ks-0.38 ks+0.38],[nanmedian(MedIntNorms{ks}) nanmedian(MedIntNorms{ks})],'k--','linewidth', 3)
    end
    
    ypos = prctile([MedIntNorms{:}],98); % for *** positioning
    
    % statistic comparison
    for ks = 1:ns-1 % ks = 1:1 for comparing everything to the first condition only
        for kkt = ks+1:ns
            pC = ranksum(MedIntNorms{ks},MedIntNorms{kkt});
            
             if pC < 0.001
                
                txtsup = ['p < 0.001'];
                
            else
                
                txtsup = ['p = ' num2str(pC,'%.3f')];
                
            end
            
            if 5/100 > pC && pC > 1/100
                txtC = ['*  ' txtsup]  ;
                plotsig = 1;
            elseif 1/100 > pC && pC > 1/1000
                txtC = ['**  ' txtsup];
                plotsig = 1;
            elseif 1/1000 > pC
                txtC = ['***  ' txtsup];
                plotsig = 1;
            else
                txtC = ['NS  ' txtsup];
                plotsig = 0;
            end
            
            if plotsig
                
                line([ks+0.1 kkt-0.1],[ypos ypos],'color','k', 'linewidth', 1.3);
                text((ks+kkt)/2,ypos + 0.2,txtC,'HorizontalAlignment','center','fontsize',11)
                
                ypos = ypos + 0.5;
                
            end
            
        end
    end
        
    ylim([0 ypos+0.5])
    ylabel('Normalized intensity nanmedian (a.u.)','interpreter','latex','fontsize',30)
    
    % save figure
    fig = gcf;
    saveas(fig,[ff filesep 'MedIntNorms_' SaveSpecif '.fig'],'fig')
    saveas(fig,[ff filesep 'MedIntNorms_' SaveSpecif '.png'],'png')
    
    
% Normalized intensities fluctuations
 figure
    hold on
    
    set(0,'DefaultLineMarkerSize',8);
    plotSpread_V(FluctIntNorms,'distributionMarkers',{'o'},'distributionColors',col ...
        ,'xValues',1:ns,'xNames',label,'spreadWidth',0.9);
    
    for ks = 1:ns
        plot([ks-0.38 ks+0.38],[nanmedian(FluctIntNorms{ks}) nanmedian(FluctIntNorms{ks})],'k--','linewidth', 3)
    end
    
    ypos = prctile([FluctIntNorms{:}],98); % for *** positioning
    
    % statistic comparison
    for ks = 1:ns-1 % ks = 1:1 for comparing everything to the first condition only
        for kkt = ks+1:ns
            pC = ranksum(FluctIntNorms{ks},FluctIntNorms{kkt});
            
            if pC < 0.001
                
                txtsup = ['p < 0.001'];
                
            else
                
                txtsup = ['p = ' num2str(pC,'%.3f')];
                
            end
            
            if 5/100 > pC && pC > 1/100
                txtC = ['*  ' txtsup]  ;
                plotsig = 1;
            elseif 1/100 > pC && pC > 1/1000
                txtC = ['**  ' txtsup];
                plotsig = 1;
            elseif 1/1000 > pC
                txtC = ['***  ' txtsup];
                plotsig = 1;
            else
                txtC = ['NS  ' txtsup];
                plotsig = 0;
            end
            
            if plotsig
                
                line([ks+0.1 kkt-0.1],[ypos ypos],'color','k', 'linewidth', 1.3);
                text((ks+kkt)/2,ypos + 0.2,txtC,'HorizontalAlignment','center','fontsize',11)
                
                ypos = ypos + 0.5;
                
            end
            
        end
    end
        
    ylim([0 ypos+0.5])
    ylabel('Normalized intensity fluctuations (a.u.)','interpreter','latex','fontsize',30)
    
    % save figure
    fig = gcf;
    saveas(fig,[ff filesep 'FluctIntNorms_' SaveSpecif '.fig'],'fig')
    saveas(fig,[ff filesep 'FluctIntNorms_' SaveSpecif '.png'],'png')


end

