funcprot(0);
chemin = 'C:\Users\Hugo Jové (sécurité)\Desktop\ENSSAT\Semestre 4 Ecole - 2017\Traitement_images\';
image = 'test.png';

function main()
    chdir(chemin);
    getd('filtres');
    getd('utils');
    getd('scripts');
    
    img = chargerImage('images/'+image,1);
    disp("Matrice initiale");
    disp(img);
    
    [filtre_gaussien, coef, nom] = creerFiltreGaussien5x5();
    img_gaussien = appliquerFiltre(img, filtre_gaussien, coef, nom);
       
    [Es, Eo] = calculGradient(img_gaussien);
    img_non_max = supprimerNonMax(Es, Eo);  
    
    stacksize(16000000);
    img_hysteresis = seuillageHysteresis(img_non_max, Es, Eo)
//    disp(floor(img_non_max))
//    calculSeuils(Es)

    toutes_img = [img img_gaussien; img_non_max img_hysteresis]
    afficherImage(toutes_img);
endfunction

main()
