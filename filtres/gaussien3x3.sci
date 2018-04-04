function [filtre, coef, nom] = creerFiltreGaussien3x3()
    filtre = [1 2 1;
              2 4 2;
              1 2 1];
    coef = 16;
    nom = 'Gaussien 3x3';
endfunction
