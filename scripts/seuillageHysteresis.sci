function image_traitee = seuillageHysteresis(matrice, Es, Eo, ratio)
    
    afficherLogs("Seuillage par hystéresis");
    
    [N,M] = size(matrice);
    image_traitee = zeros(N,M);
    
    [tableauGris, histogramme, histogrammeNormalise, cumul] = egaliserHistogramme(Es);
    [high, low] = calculSeuils(tableauGris, cumul, ratio);
    
    afficherLogs(high);
    afficherLogs(low);
    
    // On représente l'image temporaire par deux valeurs 255 ou 0
    // Afin de laisser seulement des contours sur l'image finale
    // c'est un premier traitement qui se base sur le seuil haut et le seuil bas
    temp = matrice;
    for x = 1 : N
        for y = 1 : M
            if matrice(x,y) >= high then
                temp(x,y) = 255;
                image_traitee(x,y) = 255;
            elseif matrice(x,y) < low then
                temp(x,y) = 0;
                image_traitee(x,y) = 0;
            end
        end
    end
    afficherLogs("Matrice partiellement traitée");   
    afficherLogs(temp)

    // Il reste maintenant à trouver les contour qui se situe entre le seuil haut et le seuil bas
    // Pour cela, on vérifie si l'un des voisins opposés (+90°) à la direction du pixel est un contour
    // Si c'est le cas, le pixel devient également un contour
    for x = 1: N
        for y = 1 : M
            
            if ((temp(x,y) ~= 0) & (temp(x,y) ~= 255)) then
                
                direction_pix = approximer(Eo(x,y)+90);
                [x1, y1, x2, y2] = recupererPixelsVoisins(direction_pix, x, y);
                voisin1 = verifierSiPixelExiste(x1,y1, temp);
                voisin2 = verifierSiPixelExiste(x2,y2, temp);
                
                if (voisin1 == 255) | (voisin2 == 255) then
                    image_traitee(x,y) = 255;
                else
                    image_traitee(x,y) = 0;
                end
            end
        end     
    end
    
    afficherLogs("Image finale");
    afficherLogs(image_traitee);
endfunction

