function [high, low] = calculSeuils(tableauGris, cumul, ratio) 
    afficherLogs("Calcul des seuils");
    ratio = ratio/100;
    disp(cumul)
    i = 1;  
    while(cumul(i) < ratio)
        i = i+1;
    end

    high = i;
    low = high/2;
endfunction
