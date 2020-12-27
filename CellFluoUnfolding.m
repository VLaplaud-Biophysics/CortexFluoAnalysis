function CellFluoUnfolding(path,savepath,Names,th,varargin)
% chemin vers la stack, nom de la stack (sans .tif),threshold pour
% binarisation,

warning('off','all')
set(0,'DefaultFigureWindowStyle','docked')
set(0,'DefaultTextInterpreter','none');

% dossier de sauvegarde
ff = savepath;
mkdir(ff)




%% boucle sur les vid�os

for kname = 1:length(Names)
    
    stackname = Names{kname};
    
    if size(varargin)==0
    savename = stackname;
    else
        savename = varargin{1}{kname};
    end
    
    %% depliage de l'image
    
    
    if exist([path filesep stackname '_Fluo_Unfolded.tif'])
        delete([path filesep stackname '_Fluo_Unfolded.tif'])
    end
    
    ptr = Inf;
    
    % r�cup�ration du nombre d'images
    Iinfo = imfinfo([path filesep stackname '.tif']);
    stacksize = length(Iinfo)-1;
    
    Res = Iinfo(1).XResolution;
    
    % r�up�ration de la stack, selection de la cellules seulement et calcul des centres
    [Xc,Yc,ImgStack] = findcenter(path,stackname,stacksize,th);
    
  
    savename1   = [ff filesep savename '_CleanedUp.tif'];
    
    if exist(savename1)
        delete(savename1)
    end
    
    for ks = 1:stacksize
        imwrite(ImgStack{ks}, savename1, 'WriteMode', 'append', 'Compression','none','resolution',Res);
    end
      
    
    % Cr�ation de l'image d�pli�e a la bonne taille
    [ly,lx] = getoutputsize(ImgStack{1},Xc(1),Yc(1));
    UfI = uint8(zeros([lx,ly,stacksize]));
    
    % D�pliage image par image
    for ks = 1:stacksize
        Itmp = ImgStack{ks};
        
        
        %                 figure(1)
        %                 imshow(Itmp)
        %                 hold on
        %                 plot(Xc,Yc,'*')
        %                 pause
        %                 hold off
        
        UfI(:,:,ks) = RadialUnfolding(Itmp,Xc(ks),Yc(ks));
        
%         figure(2)
%         imshow(UfI(:,:,ks))
%         pause
        
        UfImask = UfI(:,:,ks) <2;
        A = all(UfImask,2);
        Aptr = find(diff(A) ~= 0);
        ptr = min([ptr,min(Aptr)]);
        
        
    end
    
    UfI = UfI(ptr+1:end,:,:);
    
    savename3 = [ff filesep savename '_Unfolded.tif'];
    
    if exist(savename3)
        delete(savename3)
    end
    
    for ks = 1:stacksize
        imwrite(UfI(:,:,ks), savename3, 'WriteMode', 'append', 'Compression','none','resolution',Res);
        
    end
    
end


end


function [Lx,Ly] = getoutputsize(pic,Xc,Yc)

pic = double(pic);

lx = size(pic,1);
ly = size(pic,2);

Lx = 361; % 360 deg

% rayon max = du centre au coin le plus loin
Ly = ceil(sqrt(2)*max(lx,ly))+1;

end
