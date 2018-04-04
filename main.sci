funcprot(0);

chemin = 'C:\Users\Hugo Jové (sécurité)\Desktop\ENSSAT\Semestre 4 Ecole - 2017\Traitement_images\';

function image = chargerImage(path, isRGB)
    if(isRGB == 0) then
        image = double(imread(path));
    else
        image = double(rgb2gray(imread(path)));
    end
endfunction

function afficherImage(image)
    imshow(uint8(image));
endfunction

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
//    disp(temp)
    
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


function [Es, Eo] = calculGradient(image)

    [Gx, nom1] = creerFiltreGradientX()
    [Gy, nom2] = creerFiltreGradientY()
    Jx = appliquerFiltre(image, Gx, 0, nom1)
    Jy = appliquerFiltre(image, Gy, 0, nom2)
    
    [N,M] = size(image)
    for x = 1 : N
        for y = 1 : M
            Es(x,y) = sqrt(Jx(x,y)^2+Jy(x,y)^2)
            Eo(x,y) = approximer(atan(-Jx(x,y),Jy(x,y))*180/%pi)
        end
    end
    
    disp(Eo)
endfunction

function direction = approximer(angle)
    
    if(((angle < 22.5) & (angle > -22.5)) | (angle > 157.5) | (angle < -157.5)) then
        direction = 0;
     elseif(((angle > 22.5) & (angle < 67.5)) | ( (angle < -112.5) & (angle > -157.5))) then
        direction = 45;
     elseif(((angle > 67.5) & (angle < 112.5)) | ((angle < -67.5) & (angle > -112.5))) then
        direction = 90;
     elseif (((angle > 112.5) & (angle < 157.5) ) | ( (angle < -22.5) & (angle > -67.5))) then
        direction = 135;
     end
endfunction

// #############################
// 2/
// #############################

function [x1, y1, x2, y2] = recupererPixelsVoisins(gradient, i, j)
    if(gradient == 0) then
            x1 = i;
            y1 = j-1;
            x2 = i;
            y2 = j+1;
    elseif(gradient == 45) then
            x1 = i-1;
            y1 = j+1;
            x2 = i+1;
            y2 = j-1;
    elseif(gradient == 90) then
            x1 = i-1;
            y1 = j;
            x2 = i+1;
            y2 = j;
    elseif(gradient == 135) then
            x1 = i-1;
            y1 = j-1;
            x2 = i+1;
            y2 = j+1;
    end
endfunction

function resultat_pixel = verifierSiPixelExiste(i,j, matrice)
    [N, M] = size(matrice)
    if (i > 0 & i <= N) & (j > 0 & j <= M) then
        resultat_pixel = matrice(i,j)
    else
        resultat_pixel = 0;
    end
endfunction


function image_traitee = supprimerNonMax(Es, Eo)
    
    disp("Suppression des non-maximums");
    [N,M] = size(Es);
    
    for x = 1 : N
        for y = 1 : M
            
            [x1, y1, x2, y2] = recupererPixelsVoisins(Eo(x,y),x,y);
            voisin1 = verifierSiPixelExiste(x1,y1, Es);
            voisin2 = verifierSiPixelExiste(x2,y2, Es);
            
            if Es(x,y) < voisin1 | Es(x,y) < voisin2 then
                image_traitee(x,y) = 0;
            else
                image_traitee(x,y) = Es(x,y);
            end
        end
    end
endfunction



function image_traitee = seuillageHysteresis(Es_non_max, Eo_non_max)
    
    [N,M] = size(Es_non_max);
    image_traitee = zeros(N,M);
    
    high = 0.8;
    low = 0.2;
    
    for x = 1 : N
        for y = 1 : M
            if Es_non_max(x,y) >= high then
                image_traitee(x,y) = 255;
            end
            if Es_non_max(x,y) >= low then
                
                direction_pix = approximer(Eo_non_max(x,y)+90)
                
                
            end
        end     
    end
 
endfunction

function main()
    chdir(chemin);
    getd('filtres');
    
    img = chargerImage('images/contour.png',1);
    disp("Matrice initiale");
    disp(img);
    
    [filtre_gaussien, coef, nom] = creerFiltreGaussien3x3();
    img_gaussien = appliquerFiltre(img, filtre_gaussien, coef, nom);    

    [Es, Eo] = calculGradient(img_gaussien)
    
    img_non_max = supprimerNonMax(Es, Eo)
//    disp(floor(img_non_max))
    toutes_img = [img img_gaussien; img_non_max img_non_max]
    afficherImage(toutes_img);
endfunction

main()
