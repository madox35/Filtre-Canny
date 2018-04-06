function [high, low] = calculSeuils(tableauGris, cumul, ratio) 
    afficherLogs("Calcul des seuils");
    
    ratio = ratio/100;
    
    i = 1;  
    while(ratio > cumul(i))
        i = i+1;
    end

    high = i;
    low = high/2;
endfunction
