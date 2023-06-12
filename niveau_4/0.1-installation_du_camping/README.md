D'abord une solution naive qui passe presque tous les tests :

L'idée est de parcourir tous les carrés possibles dans la parcelle totale représentant le camping.
Ainsi pour chaque zone formée d'un point p_ij du carré l'on essaie d'étendre tant qu'on cette zone en bas et à droite.
L'optimisation de cette solution naïve consiste en deux choses : 
    * L'on retient les points du carrés sur la diagonale bas-droite partant du point p_ij étant dans un carré libre et l'on ne traite pas ces points.
    * soit c la taille maximale du meilleur carré trouvé jusqu'ici et un point p_ij du camping, l'on regarde d'abord si l'aggrandissement de un du carré délimité par (p_ij, (fst p_ij+c, snd p_ij+c)) est possible (pas de débordement et toutes les zones sont libres) puis éventuellement nous vérifions le carré en entier.
    
Une seconde approche du problème est construite sur une observation géométrique : 
Soit un sous-rectangle `sr` du camping et un points avec trop de monstiques (dit "point de coupures").
Alors la taille maximale d'un carré de sr est égale à la taille maximale parmis les quatres sous-rectangles suivants, notés sr1, ..., sr4 :

De plus, chacun de ces sous-rectangles contient strictement moins de points de coupures.
Ainsi, par récurrence, nous pouvons obtenir les carrés sans points de coupures.
