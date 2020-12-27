%% script pour l'utilisation de cellfluounfolding


%%%%%%%%%%%% Parametres
Path = ''; % dossier ou sont les vidéo

SavePath = ''; % dossier pour la sauvegarde

Names = {'Vidéo1','Video2', }; % liste des vidéos a analyser

SaveNames = {'Vidéo1New',}; % nom d'enregistrement (facultatif)

threshold = 5; % a changer en fonction des images


%%%%%%%%%%%%%% Execution - Rien a changer

CellFluoUnfolding(Path,SavePath,Names,threshold,SaveNames)