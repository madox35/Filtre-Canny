function [filtre, coef, nom] = creerFiltreMoyenneur5x5()
    filtre = [1 1 1 1 1;
              1 1 1 1 1;
              1 1 1 1 1;
              1 1 1 1 1;
              1 1 1 1 1];
    coef = 25;
    nom = 'Moyenneur 5x5';
endfunction
