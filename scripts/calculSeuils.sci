function [Th,Tl] = calculSeuils(es, ratio, nbIndexHistogramme)
    disp("Calcul des seuils ratio = "+ string(ratio));
    
    [N,M] = size(es);
    ratio = ratio / 100;
  
    // On commence par arrondir les valeurs décimales
    imgMatriceEntiere(i,j) = floor(es);
    
    // On récupère le min et le max de la matrice
    valMin = min(imgMatriceEntiere);
    valMax = max(imgMatriceEntiere);
    
    step = (valMax - valMin) / nbIndexHistogramme;

    // Initialisations des tableaux des histogrammes
    histogrammeIndex = zeros(1, nbIndexHistogramme + 1);
    histogramme = zeros(1, nbIndexHistogramme + 1);

    for i = 2 : size(histogrammeIndex,2)
        histogrammeIndex(i) = ((step * i) - step);
    end

    for i = 1 : N
        for j = 1 : M
            val = imgMatriceEntiere(i,j);
            index = floor((val - valMin) / step) + 1;
            histogramme(index) = histogramme(index) + 1;
        end
    end

    // On normalise l'histogramme
    histogrammeNormalise = histogramme / sum(histogramme);
    
    // On fait la répartition de l'histogramme normalisé
    repartition = cumsum(histogrammeNormalise);

    i=1;
    while repartition(i) < ratio
        i=i+1;
    end

    Th = histogrammeIndex(i);
    Tl = Th / 2;
endfunction
