function [filtre, coef, nom] = creerFiltreConique()
   filtre = [0 0 1 0 0;
             0 2 2 2 0;
             1 2 5 2 1;
             0 2 2 2 0;
             0 0 1 0 0];
    coef = 25;
    nom = 'Conique';
endfunction
