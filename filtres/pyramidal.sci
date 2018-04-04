function [filtre, coef, nom] = creerFiltrePyramidal()
    filtre = [1 2 3 2 1;
              2 4 6 4 2;
              3 6 9 6 3;
              2 4 6 4 2;
              1 2 3 2 1];
    coef = 81;
    nom = 'Pyramidal';
endfunction
