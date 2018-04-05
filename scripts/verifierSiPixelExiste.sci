function resultat_pixel = verifierSiPixelExiste(i,j, matrice)
    [N, M] = size(matrice)
    if (i > 0 & i <= N) & (j > 0 & j <= M) then
        resultat_pixel = matrice(i,j)
    else
        resultat_pixel = 0;
    end
endfunction
