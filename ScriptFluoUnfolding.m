%% script pour l'utilisation de cellfluounfolding


%%%%%%%%%%%% Parametres
Path = ''; % dossier ou sont les vid�o

SavePath = ''; % dossier pour la sauvegarde

Names = {'Vid�o1.tif','Video2.tif', }; % liste des vid�os a analyser

threshold = 5; % a changer en fonction des images


%%%%%%%%%%%%%% Execution - Rien a changer

CellFluoUnfolding(Path,SavePath,Names,threshold)