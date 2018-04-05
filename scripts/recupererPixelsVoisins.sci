// #############################
// 2/
// #############################

function [x1, y1, x2, y2] = recupererPixelsVoisins(gradient, i, j)
    if(gradient == 0) then
            x1 = i;
            y1 = j-1;
            x2 = i;
            y2 = j+1;
    elseif(gradient == 45) then
            x1 = i-1;
            y1 = j+1;
            x2 = i+1;
            y2 = j-1;
    elseif(gradient == 90) then
            x1 = i-1;
            y1 = j;
            x2 = i+1;
            y2 = j;
    elseif(gradient == 135) then
            x1 = i-1;
            y1 = j-1;
            x2 = i+1;
            y2 = j+1;
    end
endfunction
