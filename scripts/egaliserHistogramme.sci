function [tableauGris, histogramme, histogrammeNormalise, cumul] = egaliserHistogramme(matrice)
    
    matrice = floor(matrice);
    [N,M] = size(matrice);
    nbNiveauxGris = 256;
    
    // initilisation des tableaux
    tableauGris = zeros(1, nbNiveauxGris);
    histogramme = zeros(1, nbNiveauxGris);
    histogrammeNormalise = zeros(1, nbNiveauxGris);
    cumul = zeros(1, nbNiveauxGris);
    
    for i=1:nbNiveauxGris
        tableauGris(1,i) = i;
    end
    
    for x=1 : N
        for y=1 : M
            
            i = matrice(x,y);
            if i > 256 then
                i = 256;
            elseif i == 0
                i = 1
            end       
            histogramme(1, i) = histogramme(1, i) + 1;
        end
    end
    
    // On normalise l'histogramme
    histogrammeNormalise = histogramme / sum(histogramme);
    
    // On fait la répartition de l'histogramme normalisé
    cumul = cumsum(histogrammeNormalise);
endfunction
