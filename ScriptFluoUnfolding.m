%% script pour l'utilisation de cellfluounfolding


%%%%%%%%%%%% Parametres
Path = ''; % dossier ou sont les vid�o

SavePath = ''; % dossier pour la sauvegarde

Names = {'Vid�o1','Video2', }; % liste des vid�os a analyser

SaveNames = {'Vid�o1New',}; % nom d'enregistrement (facultatif)

threshold = 5; % a changer en fonction des images


%%%%%%%%%%%%%% Execution - Rien a changer

CellFluoUnfolding(Path,SavePath,Names,threshold,SaveNames)