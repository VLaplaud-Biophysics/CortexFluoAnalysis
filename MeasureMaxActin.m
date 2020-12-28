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
AllFlucts = [];

for kn = 1:length(Names)
    %% Chargement de l'image déplié
    imgname = [path filesep Names{kn} '_Unfolded.tif'];
    if exist(imgname)
        
        
        name = Names{kn};
        MA{kn}.name = name;
        
        Iinfo = imfinfo(imgname);
        stacksize = length(Iinfo);
        
        pos = [30 60 90 120 150 180 210 240 270 300 330];
        MA{kn}.pos = pos;
        npos = length(pos);
        posn = 1:npos;
        MA{kn}.posn = posn;
        
        IntTime = zeros(stacksize,npos);
        
        MedInt = [];
        FluctInt = [];
        
        
        for ks = 1:stacksize
            
            ImgCurrent = imread(imgname,'tiff',ks);
            
            [lx,~] = size(ImgCurrent);
            
            if PLOTVID
                figure(1)
                imshow(ImgCurrent)
            end
            
            %% Mesure de l'actin Max au cours du temps a plusieur endroit sur le cortex
            
            
            for kp = 1:length(pos)
                line = double(ImgCurrent(:,pos(kp)));
                
                
                [MaxInt,MaxPos] = max(line);
                
                IntTime(ks,kp) = MaxInt;
                
                if PLOTVID
                    figure(1)
                    hold on
                    plot([pos(kp) pos(kp)],[1 lx],'-y')
                    plot(pos(kp),MaxPos,'ro','markersize',5,'markerfacecolor','r')
                    text(pos(kp)-5,0.1*lx,num2str(posn(kp)),'fontsize',20,'color','w','fontname','serif','fontweight','bold','horizontalalignment','center')
                end
            end
            
            if PLOTVID
                figure(1)
                pause(0.1)
                Frames(ks) = getframe(gcf);
                hold off
            end
            
        end
        
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
            
            CurveInt = IntTime(:,kp);
            MedInt = [MedInt median(CurveInt)];
            FluctInt = [FluctInt (prctile(CurveInt,90)-prctile(CurveInt,10))];
            
            if PLOTFIG
                figure
                hold on
                plot(smooth(CurveInt),'color',col,'linewidth',1.5)
                title([Names{kn} '-' num2str(posn(kp))])
                xlabel('Time (s)')
                ylabel('Intensity (a.u.)')
                fig = gcf;
                saveas(gcf,[ff filesep Names{kn} '-' num2str(pos(kp)) '_TimeINtensity.png'])
                saveas(gcf,[ff filesep Names{kn} '-' num2str(pos(kp)) '_TimeINtensity.fig'])
                close
            end
        end
        
        MA{kn}.MedInts = MedInt;
        MA{kn}.FluctInts = FluctInt;
        
        AllMeds = [AllMeds MedInt];
        AllFlucts = [AllFlucts FluctInt];
        
    else
        error([imgname ' not found']);
    end
    
end

MA{kn}.AllMeds = AllMeds;
MA{kn}.AllFlucts = AllFlucts;

save([sf filesep 'MA_' specif],'MA')
end