function direction = approximer(angle)
    
    if(((angle < 22.5) & (angle > -22.5)) | (angle > 157.5) | (angle < -157.5)) then
        direction = 0;
     elseif(((angle > 22.5) & (angle < 67.5)) | ( (angle < -112.5) & (angle > -157.5))) then
        direction = 45;
     elseif(((angle > 67.5) & (angle < 112.5)) | ((angle < -67.5) & (angle > -112.5))) then
        direction = 90;
     elseif (((angle > 112.5) & (angle < 157.5) ) | ( (angle < -22.5) & (angle > -67.5))) then
        direction = 135;
     end
endfunction
