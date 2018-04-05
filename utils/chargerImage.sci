function image = chargerImage(path, isRGB)
    if(isRGB == 0) then
        image = double(imread(path));
    else
        image = double(rgb2gray(imread(path)));
    end
endfunction
