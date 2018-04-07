funcprot(0);

CHEMIN = 'C:\Users\Hugo Jové (sécurité)\Desktop\ENSSAT\Semestre 4 Ecole - 2017\Traitement_images\';
IMAGE1 = 'test_3x3.png';
IMAGE2 = 'test_5x5.png';
IMAGE3 = 'test_20x20.png';
IMAGE4 = 'murray.jpg';

global AFFICHER_LOGS
AFFICHER_LOGS = %f; // %T = vrai / %F = faux

function filtreCanny(chemin, image, seuil)
    
    [lhs,rhs]=argn(0);
    if rhs < 3 then
        error("Au moins 3 paramètres attendus...");
    end
    
    chdir(chemin);
    getd('filtres');
    getd('utils');
    getd('scripts');
    
    img = chargerImage('images/'+image,1);
    afficherLogs("Matrice initiale");
    afficherLogs(img);
    
    [filtre, coef, nom] = creerFiltreGaussien3x3();
    img_gaussien = appliquerFiltre(img, filtre, coef, nom);
       
    [Es, Eo] = calculGradient(img_gaussien);
    img_non_max = supprimerNonMax(Es, Eo);  
    
    stacksize(16000000);
    img_hysteresis = seuillageHysteresis(img_non_max, Es, Eo, seuil)

    toutes_img = [img img_gaussien; img_non_max img_hysteresis]
    afficherImage(toutes_img);
endfunction

filtreCanny(CHEMIN, IMAGE4, 90);
