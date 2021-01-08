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

for kn = 1:length(Names)
    %% Chargement de l'image déplié
    imgname = [path filesep Names{kn} '_Unfolded.tif'];
    if exist(imgname)
        
        
        name = Names{kn};
        MA{kn}.name = name;
        
        Iinfo = imfinfo(imgname);
        stacksize = length(Iinfo);
        
        pos = [15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345];
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
            
            
            MeanBckgrndImg(ks) = mean(mean(ImgCurrent(lx-4:lx,:)));
            
            if PLOTVID
                figure(1)
                pause(0.1)
                Frames(ks) = getframe(gcf);
                hold off
            end
            
        end
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
            
            CurveExt = Extensions(:,kp);
            
            CurveInt = IntTime(CurveExt<21,kp);
%             CurveInt = IntTime(:,kp);
            MedInt(kp) =  median(CurveInt);
            FluctInt(kp) = prctile(CurveInt,90)-prctile(CurveInt,10);
            
            if PLOTFIG
                figure
                hold on
                plot(smooth(CurveInt),'color',col,'linewidth',1.5)
                plot([1 length(CurveInt)],[median(CurveInt) median(CurveInt)],'r','linewidth',1.3)
                plot([1 length(CurveInt)],[prctile(CurveInt,90) prctile(CurveInt,90)],'k--')
                plot([1 length(CurveInt)],[prctile(CurveInt,10) prctile(CurveInt,10)],'k--','handlevisibility','off')
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
                plot(smooth(CurveInt),'color',col,'linewidth',1.5)
                plot(MeanBckgrndImg,'color','r','linewidth',1.5)
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
    else
        error([imgname ' not found']);
    end
    
end

save([sf filesep 'MA_' specif],'MA','AllMeds','AllFlucts','AllMedNorms','AllFluctNorms','AllBckGrnd')
end