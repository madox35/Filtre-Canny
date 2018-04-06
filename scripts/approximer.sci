function direction = approximer(angle)

    if(angle > 180) then
        angle = angle - 180;
    end
    // première condition différente car si l'angle = 176 par exemple,
    // on respectera bien >= 157.5 mais pas <= -157.5
    // se référer au schéma directions.png
    
    if( ((angle >= -22.5) & (angle <= 22.5)) | (angle <= -157.5) | (angle >= 157.5) ) then
        direction = 0;
     elseif( ((angle > 22.5) & (angle <= 67.5)) | ((angle > -157.5) & (angle <= -112.5)) ) then
        direction = 45;
     elseif( ((angle > 67.5) & (angle <= 112.5)) | ((angle > -112.5) & (angle <= -67.5)) ) then
        direction = 90;
     elseif( ((angle > 112.5) & (angle < 157.5) ) | ((angle > -67.5) & (angle < -22.5)) ) then
        direction = 135;
     end
endfunction
