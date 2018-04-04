function [filtre, coef, nom] = creerFiltreGaussien5x5()
    filtre = [1,4,6,4,1;
              4,16,24,16,4;
              6,24,36,24,6;
              4,16,24,16,4;
              1,4,6,4,1];
    coef = 256;
    nom = 'Gaussien 5x5';
endfunction
