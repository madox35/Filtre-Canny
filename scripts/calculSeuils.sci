function [high, low] = calculSeuils(Es)
    
    disp("Calcul des seuils");
    [N,M] = size(Es);
    
    Es_floor = floor(Es);
    mini = min(Es_floor);
    maxi = max(Es_floor);
    step = (maxi - mini)/3;
    
    
    
    high = 0;
    low = high/2;
endfunction 
