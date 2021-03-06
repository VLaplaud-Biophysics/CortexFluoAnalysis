function MeasureMaxActin(path,savepath,Names,specif,col,PLOTFIG,PLOTVID)

%% INIT

warning('off','all')

close all
set(0,'DefaultFigureWindowStyle','docked')
set(0,'DefaultTextInterpreter','none');
set(0,'DefaultAxesFontSize',15)

sf   = savepath;
ff = [sf filesep 'Figures' filesep 'Curves'];
vf = [sf filesep 'Videos'];

mkdir(sf)
if PLOTFIG
    mkdir(ff)
end
if PLOTVID
    mkdir(vf)
end


%% Main

AllMeds = [];
AllMedNorms = [];
AllFlucts = [];
AllFluctNorms = [];
AllBckGrnd = [];
AllSpatialVar = [];

AllCurveInts = {};
AllTimes = {};

for kn = 1:length(Names)
    %% Chargement de l'image d�pli�
    imgname = [path filesep Names{kn} '_Unfolded.tif'];
    if exist(imgname)
        
        
        name = Names{kn};
        MA{kn}.name = name;
        
        Iinfo = imfinfo(imgname);
        stacksize = length(Iinfo);
        
        pos = 10:10:350;
        MA{kn}.pos = pos;
        npos = length(pos);
        posn = 1:npos;
        MA{kn}.posn = posn;
        
        IntTime = zeros(stacksize,npos);
        IntPos = zeros(stacksize,npos);
        Extensions = zeros(stacksize,npos);
        
        MedInt = nan(1,npos);
        FluctInt = nan(1,npos);
        MeanBckgrndImg = nan(1,stacksize);
        
        
        for ks = 1:stacksize
            
            ImgCurrent = imread(imgname,'tiff',ks);
            
            [lx,ly] = size(ImgCurrent);
            
            if PLOTVID
                figure(1)
                imshow(imadjust(ImgCurrent))
                rectangle('Position',[1 lx-4 ly-1 4],'EdgeColor','g','linewidth',1.5)
            end
            
            %% Mesure de l'actin Max au cours du temps a plusieur endroit sur le cortex
            
            
            for kp = 1:length(pos)
                line = double(ImgCurrent(:,pos(kp)));
                
                if ~all(line == 0)
                    
                    CortLim = find(line>0,1);
                    
                    [MaxInt,MaxPos] = max(line);
                    
                    IntTime(ks,kp) = MaxInt;
                    IntPos(ks,kp) = MaxPos;
                    
                    Extensions(ks,kp) = MaxPos - CortLim;

                    
                    if PLOTVID
                        figure(1)
                        hold on
                        plot([pos(kp) pos(kp)],[1 lx],'-y')
                        plot(pos(kp),MaxPos,'ro','markersize',5,'markerfacecolor','r')
                        text(pos(kp)-5,0.1*lx,num2str(posn(kp)),'fontsize',20,'color','w','fontname','serif','fontweight','bold','horizontalalignment','center')
                        
                    end
                end
            end
            
            BckgrndPixels = ImgCurrent(lx-20:lx,:);
            MeanBckgrndImg(ks) = mean(BckgrndPixels(BckgrndPixels>0));
            
            if PLOTVID
                figure(1)
                pause(0.1)
                Frames(ks) = getframe(gcf);
                hold off
            end
            
        end
        
        
        
        SortedIntTime = IntTime;
        SortedIntTime(~(Extensions<10)) = NaN; 
        
        SpatialVar = nanstd(SortedIntTime,0,2);
        
        SpatialVar(isnan(SpatialVar)) = [];
        SpatialVar(SpatialVar==0) = [];
      
        
        
%         
%         figure
%         histogram(Extensions(:))
        
        if PLOTVID
            % create the video writer with 10 fps
            writerObj = VideoWriter([vf filesep Names{kn} '_Vid'],'Uncompressed AVI');
            writerObj.FrameRate = 20;
            
            % open the video writer
            open(writerObj);
            % write the frames to the video
            for i=1:length(Frames)
                % convert the image to a frame
                frame = Frames(i) ;
                writeVideo(writerObj, frame);
            end
            % close the writer object
            close(writerObj);
            
            clear Frames frame
        end
        
        
        for kp = 1:npos
           if max(Extensions(:,kp))<500
            
           
            
      % full curves
            CurveInt = IntTime(:,kp);
             Xvect = 1:length(CurveInt);
             
             % protrusions removed
             CurveInt = IntTime(Extensions(:,kp)<10,kp);
             Xvect = find(Extensions(:,kp)<10);
             
            MedInt(kp) =  nanmedian(CurveInt);
            FluctInt(kp) = prctile(CurveInt,90)-prctile(CurveInt,10);
            
            AllCurveInts{end+1} = CurveInt;
            AllTimes{end+1} = Xvect;
            
            if PLOTFIG
                figure
                hold on
                plot(Xvect,smooth(CurveInt),'-*','color',col,'linewidth',1.5)
                plot([Xvect(1) Xvect(end)],[median(CurveInt) median(CurveInt)],'r','linewidth',1.3)
                plot([Xvect(1) Xvect(end)],[prctile(CurveInt,90) prctile(CurveInt,90)],'k--')
                plot([Xvect(1) Xvect(end)],[prctile(CurveInt,10) prctile(CurveInt,10)],'k--','handlevisibility','off')
                title([Names{kn} '-' num2str(posn(kp))])
                xlabel('Time (s)')
                ylabel('Intensity (a.u.)')
                legend('MaxIntensity','Median','First and last decile')
                fig = gcf;
                saveas(gcf,[ff filesep Names{kn} '-' num2str(pos(kp)) '_TimeIntensity.png'])
                saveas(gcf,[ff filesep Names{kn} '-' num2str(pos(kp)) '_TimeIntensity.fig'])
                close
                
                figure
                hold on
                plot(Xvect,smooth(CurveInt),'-*','color',col,'linewidth',1.5)
                plot(Xvect,MeanBckgrndImg,'-*','color','r','linewidth',1.5)
                title([Names{kn} '-' num2str(posn(kp))])
                xlabel('Time (s)')
                ylabel('Intensity (a.u.)')
                legend('MaxIntensity','CellBackground')
                fig = gcf;
                saveas(gcf,[ff filesep Names{kn} '-' num2str(pos(kp)) '_TimeIntensitywBckGrnd.png'])
                saveas(gcf,[ff filesep Names{kn} '-' num2str(pos(kp)) '_TimeIntensitywBckGrnd.fig'])
                close
            end
            
        end
        end
                
        MA{kn}.MedInts = MedInt;
        MA{kn}.MedIntNorms = MedInt/mean(MeanBckgrndImg);
        MA{kn}.FluctInts = FluctInt;
        MA{kn}.FluctIntNorms = FluctInt/mean(MeanBckgrndImg);
        MA{kn}.TimeBckGrnd = MeanBckgrndImg;
        MA{kn}.BckGrnd = mean(MeanBckgrndImg);
        
        AllMeds = [AllMeds MedInt];
        AllMedNorms = [AllMedNorms MedInt/mean(MeanBckgrndImg)];
        AllFlucts = [AllFlucts FluctInt];
        AllFluctNorms = [AllFluctNorms FluctInt/mean(MeanBckgrndImg)];
        AllBckGrnd = [AllBckGrnd mean(MeanBckgrndImg)];
          
        AllSpatialVar = [AllSpatialVar SpatialVar(1:30:end)'];
    else
        error([imgname ' not found']);
    end
    
end

% DecorrTimes = GetTaus(AllCurveInts,AllTimes);

save([sf filesep 'MA_' specif],'MA','AllMeds','AllFlucts','AllMedNorms','AllFluctNorms','AllBckGrnd','AllSpatialVar')
end


function Taus = GetTaus(Distances,Times)
figure
hold on

MinTime = 300;
Taus = [];
AllR2 = [];
for k = 1:length(Distances)
    T = Times{k};
    D3 = Distances{k};
    
    
    if (T(end) - T(1) > MinTime) &&  ((T(end)-T(1))/(length(T)-1) <= 1)
        
        [C,L] = AUTOCORR(T,D3,2);
        
        expfitfun = fittype('exp(-x/T)');
        
        [expfit,gof] = fit(L(L<200)',C(L<200)',expfitfun);
        
        plot(L,C)
        
        R2 = gof.rsquare;
        
        AllR2 = [AllR2 R2];
        
        if R2>0.6
            Tau = coeffvalues(expfit);
            Taus = [Taus Tau];
            
            
        end
        
        
        
    end
end
%
% figure
% histogram(AllR2,'binwidth',0.02)


end