function [tableauGris, histogramme, histogrammeNormalise, cumul] = egaliserHistogramme(matrice)
    
    matrice = floor(matrice);
    [N,M] = size(matrice);
    minimum = min(matrice);
    maximum = max(matrice);
    nbNiveauxGris = maximum - minimum;
    
    tableauGris = zeros(1, nbNiveauxGris);
    histogramme = zeros(1, nbNiveauxGris);
    histogrammeNormalise = zeros(1, nbNiveauxGris);
    cumul = zeros(1, nbNiveauxGris);
    
    for i=1 : nbNiveauxGris
        tableauGris(1,i) = minimum + i;
    end
    
    for x=1 : N
        for y=1 : M
            
            valeur = matrice(x,y);
            i = valeur-minimum+1;
            if i == nbNiveauxGris+1 then
                i = nbNiveauxGris
            end
            
            histogramme(1, i) = histogramme(1, i) + 1;
            histogrammeNormalise(1, i) = histogramme(1,i)/(N*M);
        end
    end
    
    cumul(1,1) = histogrammeNormalise(1,1);
    for i=2 : nbNiveauxGris
        cumul(1,i) = cumul(1,i-1) + histogrammeNormalise(1, i) ;
    end
    
//    afficherLogs(cumul);
//    bar(tableauGris, histogramme, 'red')
endfunction
