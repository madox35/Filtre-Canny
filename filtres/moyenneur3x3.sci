function [filtre, coef, nom] = creerFiltreMoyenneur3x3()
    filtre = [1 1 1;
              1 1 1;
              1 1 1];
    coef = 9;
    nom = 'Moyenneur 3x3';
endfunction
