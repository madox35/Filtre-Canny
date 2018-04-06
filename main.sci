funcprot(0);

CHEMIN = 'C:\Users\Hugo Jové (sécurité)\Desktop\ENSSAT\Semestre 4 Ecole - 2017\Traitement_images\';
IMAGE = 'test.png';

global AFFICHER_LOGS
AFFICHER_LOGS = %t; // %T = vrai / %F = faux

function main()
    
    chdir(CHEMIN);
    getd('filtres');
    getd('utils');
    getd('scripts');
    
    img = chargerImage('images/'+IMAGE,1);
    afficherLogs("Matrice initiale");
    afficherLogs(img);
    
    [filtre, coef, nom] = creerFiltreGaussien3x3();
    img_gaussien = appliquerFiltre(img, filtre, coef, nom);
       
    [Es, Eo] = calculGradient(img_gaussien);
    img_non_max = supprimerNonMax(Es, Eo);  
    
    stacksize(16000000);
    img_hysteresis = seuillageHysteresis(img_non_max, Es, Eo)

    toutes_img = [img img_gaussien; img_non_max img_hysteresis]
    afficherImage(toutes_img);
endfunction

main()
