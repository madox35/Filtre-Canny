function image_traitee = appliquerFiltre(image, filtre, coef, nom)
    disp("Application d''un filtre : "+ nom);
    
    [N, M] = size(image)
    [NMasque, MMasque]= size(filtre)
    NMasque_moitie = floor(NMasque/2);
    MMasque_moitie = floor(MMasque/2);

    // Matrice temporaire dans laquelle nous recopions la matrice de l'image de base
    // + élargissement de l'image pour pouvoir appliquer le filtre
    // Les contours seront initialisés par défaut à 0
    xtemp = 2*NMasque_moitie + N;
    ytemp = 2*MMasque_moitie + M;
    temp = zeros(xtemp,ytemp);
    [Ntemp, Mtemp] = size(temp);
    temp(NMasque_moitie + 1 : Ntemp - NMasque_moitie, MMasque_moitie + 1 : Mtemp - MMasque_moitie) = image;
//  disp(temp)
    
    image_traitee = zeros(N,M)
    for x = 1+NMasque_moitie : N+NMasque_moitie
        for y = 1+MMasque_moitie : M+MMasque_moitie
            
            somme_px = 0;
            for i = 1 : NMasque
                for j = 1 : MMasque
                    
                    x1 = x+i-NMasque_moitie-1;
                    y1 = y+j-MMasque_moitie-1;
                    px_img = temp(x1, y1);
                    px_filtre = filtre(i,j);

//                   Gros bug ici car j'avais mis y1 = y+i-MMasque_moitie-1 au lieu de j                   
//                   disp("x:"+ string(x)+ " ; y:"+ string(y)+ " | i:"+ string(i)+ " ; j:"+ string(j))
//                   disp("Temp x: "+string(x1))
//                   disp("Temp y: "+string(y1))
                    somme_px = somme_px + px_img * px_filtre;
                end
            end
            if coef ~= 0 then
                image_traitee(x-NMasque_moitie, y-MMasque_moitie) = floor(somme_px/coef);
            else 
                image_traitee(x-NMasque_moitie, y-MMasque_moitie) = floor(somme_px);
            end
            
        end
    end
    
    // On affiche la nouvelle matrice après l'application du filtre
    disp (image_traitee)
endfunction
