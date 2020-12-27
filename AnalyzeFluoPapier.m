close all;
clear all;
clc;

%% Params

% home
h='C:\Users\Valentin\Dropbox\TheseValentin\Matlab';

% Couleurs par drogues
Cdm = [0 109 219]./255; % control
Cnd = Cdm/2;

Cl  = [73 0 146]./255; % Latranculin

Cb  = [219 209 0]./255; % blebbi
Cy  = [255 255 109 ]./255; % y27
Ccl = [146 0 0]./255; % calyculinA 1nM
Ccl3 = Ccl/2; % calyculinA 3nM
Ccl10 = Ccl3/2; % calyculinA 10nM

Cs  = [36 255 36]./255; % smifh2

Cck = [182 109 255]./255;

Cin = [0 73 73]./255; % inside
Co  = [255 182 119]./255; % outside

% for unfolding
    datapath = 'D:\Data\MatFile\FluoMovies';

% for CHA
   savepath = 'D:\Data\MatFile\CHA';
   figurepath = 'D:\Data\Figures';
   PLOTHAIR = 0;
  

%% Unfolding

MainPath = 'F:\Raw\ConfocJudith';
SavePath = 'F:\Raw\ConfocJudith\Unfolded';

Th = 5;

% Per date and conditions

% Ctrl 20-07-2018
Folder = [MainPath filesep '18.07.20_ConfocJudith\20180720_DCValentin_TIF_Ctrl'];
Names     = {'Series002_Fluo','Series004_Fluo','Series008_Fluo','Series009_Fluo','Series011_Fluo','Series018_Fluo'};
SaveNames = {'200718_Ctrl_1' ,'200718_Ctrl_2' ,'200718_Ctrl_3' ,'200718_Ctrl_4' ,'200718_Ctrl_5' ,'200718_Ctrl_6' };

CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% CK666 20-07-18
Folder = [MainPath filesep '18.07.20_ConfocJudith\20180720_DCValentin_TIF_CK666'];
Names     = {'Series002_CK666_Fluo','Series004_CK666_Fluo','Series006_CK666_Fluo','Series008_CK666_Fluo'};
SaveNames = {'200718_CK666_1'      ,'200718_CK666_2'      ,'200718_CK666_3'      ,'200718_CK666_4'      };

CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% Ctrl 12-12-18
Folder = [MainPath filesep '18.12.12_ConfocJudith\20181212_DCLA_TIF_Ctrl'];
Names     = {'Series002_Ctrl_Fluo','Series002_Ctrl_Fluo','Series002_Ctrl_Fluo','Series002_Ctrl_Fluo'};
SaveNames = {'121218_Ctrl_1'      ,'121218_Ctrl_2'      ,'121218_Ctrl_3'      ,'121218_Ctrl_4'      ,};

CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% CK666 12-12-18
Folder = [MainPath filesep '18.12.12_ConfocJudith\20181212_DCLA_TIF_CK666'];
Names     = {'Series004_CK666_Fluo','Series006_CK666_Fluo','Series010_CK666_Fluo'};
SaveNames = {'121218_CK666_1'      ,'121218_CK666_2'     ,'121218_CK666_3'       };
 
CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% Y27 12-12-18
Folder = [MainPath filesep '18.12.12_ConfocJudith\20181212_DCLA_TIF_Y27'];
Names     = {'Series004_Y27_Fluo','Series007_Y27_Fluo','Series009_Y27_Fluo','Series011_Y27_Fluo','Series013_Y27_Fluo','Series016_Y27_Fluo'};
SaveNames = {'121218_Y27_1'      ,'121218_Y27_2'      ,'121218_Y27_3'      ,'121218_Y27_4'      ,'121218_Y27_5'      ,'121218_Y27_6'      };
 
CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% Ctrl 17-12-18
Folder = [MainPath filesep '18.12.17_ConfocJudith\20181217_DCLA_TIF_Ctrl'];
Names     = {'Series008_Ctrl_Fluo','Series011_Ctrl_Fluo'};
SaveNames = {'171218_Ctrl_1'      ,'171218_Ctrl_2'      };

CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% CK666 17-12-18
Folder = [MainPath filesep '18.12.17_ConfocJudith\20181217_DCLA_TIF_CK666'];
Names     = {'Series004_CK666_Fluo','Series008_CK666_Fluo','Series014_CK666_Fluo','Series017_CK666_Fluo','Series030_CK666_Fluo','Series034_CK666_Fluo'};
SaveNames = {'171218_CK666_1'      ,'171218_CK666_2'      ,'171218_CK666_3'      ,'171218_CK666_4'      ,'171218_CK666_5'      ,'171218_CK666_6'      };
 
CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% Y27 17-12-18
Folder = [MainPath filesep '18.12.17_ConfocJudith\20181217_DCLA_TIF_Y27'];
Names     = {'Series003_Y27_Fluo','Series005_Y27_Fluo','Series008_Y27_Fluo','Series010_Y27_Fluo','Series012_Y27_Fluo'};
SaveNames = {'171218_Y27_1'      ,'171218_Y27_2'      ,'171218_Y27_3'      ,'171218_Y27_4'      ,'171218_Y27_5'      };
 
CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% Smifh2 17-12-18
Folder = [MainPath filesep '18.12.17_ConfocJudith\20181217_DCLA_TIF_Smifh2'];
Names     = {'Series007_Smifh2_Fluo','Series009_Smifh2_Fluo','Series011_Smifh2_Fluo','Series013_Smifh2_Fluo','Series019_Smifh2_Fluo'};
SaveNames = {'171218_Smifh2_1'      ,'171218_Smifh2_2'      ,'171218_Smifh2_3'      ,'171218_Smifh2_4'      ,'171218_Smifh2_5'      };
 
CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% Ctrl 20-12-18
Folder = [MainPath filesep '18.12.20_ConfocJudith\20181220_DCLA_TIF_Ctrl'];
Names     = {'Series014_Ctrl_Fluo','Series016_Ctrl_Fluo'};
SaveNames = {'201218_Ctrl_1'      ,'201218_Ctrl_2'      };

CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


% Y27 20-12-18
Folder = [MainPath filesep '18.12.20_ConfocJudith\20181220_DCLA_TIF_Y27'];
Names     = {'Series005_Y27_Fluo','Series009_Y27_Fluo','Series014_Y27_Fluo','Series022_Y27_Fluo','Series027_Y27_Fluo'};
SaveNames = {'201218_Y27_1'      ,'201218_Y27_2'      ,'201218_Y27_3'      ,'201218_Y27_4'      ,'201218_Y27_5'      };
 
CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)



% Smifh2 20-12-18
Folder = [MainPath filesep '18.12.20_ConfocJudith\20181220_DCLA_TIF_Smifh2'];
Names     = {'Series003_Smifh2_Fluo','Series006_Smifh2_Fluo','Series007_Smifh2_Fluo','Series011_Smifh2_Fluo','Series023_Smifh2_Fluo','Series030_Smifh2_Fluo','Series036_Smifh2_Fluo','Series040_Smifh2_Fluo','Series048_Smifh2_Fluo'};
SaveNames = {'201218_Smifh2_1'      ,'201218_Smifh2_2'      ,'201218_Smifh2_3'      ,'201218_Smifh2_4'      ,'201218_Smifh2_5'      ,'201218_Smifh2_6'      ,'201218_Smifh2_7'      ,'201218_Smifh2_8'      ,'201218_Smifh2_9'      };
 
CellFluoUnfolding(Folder,SavePath,Names,Th,SaveNames)


%% Intensity fluctuations



return

%%  Hairness analysis 

    
    
    % 09-04-19
    loadpath = 'D:\Data\Raw\19.04.09_ConfocJudith\2019_04_08_17_24_56--20190408_ValDC_40x_Ctrl_01001';
    names= {'Series004--C00','Series005--C00','Series007--C00','Series009--C00','Series011--C00'...
        ,'Series013--C00','Series015--C00','Series017--C00','Series019--C00','Series021--C00','Series023--C00'...
        ,'Series025--C00','Series027--C00','Series029--C00','Series031--C00','Series033--C00','Series035--C00'...
        ,'Series038--C00','Series040--C00','Series042--C00','Series044--C00','Series046--C00','Series048--C00'...
        ,'Series050--C00','Series052--C00','Series054--C00'};
    CellHairAnalysis(loadpath,savepath,figurepath,names,'04-09-19_Ctrl_New',PLOTHAIR)
    clear names loadpath
    
    loadpath = 'D:\Data\Raw\19.04.09_ConfocJudith\2019_04_08_18_58_37--20190408_ValDC_40x_Blebb_01001';
    names= {'Series003--C00','Series005--C00','Series008--C00','Series012--C00'...  ,'Series014--C00' 
        ,'Series016--C00','Series018--C00','Series020--C00','Series022--C00','Series024--C00'...
        ,'Series027--C00','Series029--C00','Series031--C00','Series033--C00','Series035--C00','Series035--C00'...
        ,'Series037--C00','Series040--C00','Series042--C00','Series044--C00','Series047--C00','Series049--C00'...
        ,'Series052--C00','Series053--C00','Series055--C00','Series056--C00'}; % ,'Series051--C00'
    CellHairAnalysis(loadpath,savepath,figurepath,names,'04-09-19_Blebbi_New',PLOTHAIR)
    clear names loadpath
    
    loadpath = 'D:\Data\Raw\19.04.09_ConfocJudith\2019_04_08_19_53_37--20190408_ValDC_40x_CK666_01001';
    names= {'Series002--C00','Series004--C00','Series006--C00','Series008--C00','Series010--C00'...
        ,'Series012--C00','Series014--C00','Series016--C00','Series018--C00','Series020--C00'...
        ,'Series022--C00','Series024--C00','Series026--C00','Series028--C00','Series030--C00','Series032--C00'...
        ,'Series034--C00','Series036--C00','Series038--C00','Series040--C00','Series042--C00','Series044--C00'...
        ,'Series046--C00','Series048--C00','Series050--C00'};
    CellHairAnalysis(loadpath,savepath,figurepath,names,'04-09-19_CK666_New',PLOTHAIR)
    clear names loadpath
    
     loadpath = 'D:\Data\Raw\19.04.09_ConfocJudith\2019_04_08_20_46_08--20190408_ValDC_40x_SmifH2_01001';
    names= {'Series002--C00','Series004--C00','Series006--C00','Series008--C00','Series010--C00'...
        ,'Series013--C00','Series015--C00','Series017--C00','Series019--C00','Series021--C00'...
        ,'Series023--C00','Series026--C00','Series030--C00','Series032--C00'...
        ,'Series034--C00','Series036--C00','Series038--C00','Series040--C00','Series042--C00','Series044--C00'...
        ,'Series046--C00','Series048--C00','Series050--C00','Series052--C00','Series054--C00'};
    CellHairAnalysis(loadpath,savepath,figurepath,names,'04-09-19_Smifh2_New',PLOTHAIR)
    clear names loadpath
    
    loadpath = 'D:\Data\Raw\19.04.09_ConfocJudith\2019_04_08_21_09_04--20190408_ValDC_40x_Y27_01001';
    names= {'Series002--C00','Series004--C00','Series006--C00','Series008--C00','Series011--C00'...
        ,'Series013--C00','Series015--C00','Series017--C00','Series019--C00','Series021--C00'...
        ,'Series023--C00','Series025--C00','Series027--C00','Series029--C00'...
        ,'Series031--C00','Series033--C00','Series035--C00','Series037--C00','Series039--C00','Series041--C00'...
        ,'Series046--C00','Series048--C00','Series043--C00'};
    CellHairAnalysis(loadpath,savepath,figurepath,names,'04-09-19_Y27_New',PLOTHAIR)
    clear names loadpath
    

%     
%     CellHairPlot(savepath,{'Ctrl_New','Smifh2_New'},{Cdm,Cs})
% %     
% %     
% %     CellHairPlot(savepath,{'Ctrl_Old','Y27_Old','CK666_Old','Smifh2_Old'},{Cdm,Cy,Cck,Cs})
% %     
%     CellHairPlot(savepath,{'Ctrl_Old','Ctrl_New'},{Cdm,Cdm/2})
%     CellHairPlot(savepath,{'CK666_Old','CK666_New'},{Cck,Cck/2})
%     CellHairPlot(savepath,{'Smifh2_Old','Smifh2_New'},{Cs,Cs/2})
% %     CellHairPlot(savepath,{'Y27_Old','Y27_New'},{Cy,Cy/2})
    
CellHairPlot(savepath,{'Ctrl','Blebbi','CK666','Smifh2','Y27'},{Cdm,Cb,Cck,Cs,Cy})
%    
    
    
    
    
    