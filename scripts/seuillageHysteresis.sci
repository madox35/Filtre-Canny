function image_traitee = seuillageHysteresis(matrice, Es, Eo)
    
    disp("Seuillage par hystéresis")
    [N,M] = size(matrice);
    image_traitee = zeros(N,M);
    
    high = 0.8*255;
    low = 0.4*255;
    
    matrice_temp = zeros(N,M);
    for x = 1 : N
        for y = 1 : M
            if matrice(x,y) >= high then
                matrice_temp(x,y) = 255;
            end
            if matrice(x,y) < low then
                matrice_temp(x,y) = 0;
            end   
        end
    end 
            
    for x= 1: N
        for y=1 : M
                
            direction_pix = approximer(Eo(x,y)+90);
            [x1, y1, x2, y2] = recupererPixelsVoisins(direction_pix, x, y);
            voisin1 = verifierSiPixelExiste(x1,y1, matrice_temp);
            voisin2 = verifierSiPixelExiste(x2,y2, matrice_temp);
        
            if voisin1 == 255 | voisin2 == 255 then
                image_traitee(x,y) = 255;
            else
                image_traitee(x,y) = 0;
            end
        end     
    end
    
    disp(image_traitee);
 
endfunction

