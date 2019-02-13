# matlab-knn-crosse-validation-un-tires-deux-tiers-

deux fonction matlab qui facilité l'implémentation de KNN et qui donnent comme sorties le taux de classification , le spécificité , la sensibilité et la matrice de confusion 

la fonction knncrossTp1.m: pour réaliser le knn avec le cross validation .

[Tct, Set, Spt, c] = knnCrossTp1(path, num_division, k_voisin, distance);

les entrées :

path: Strign représente le directoire de la base de données 

num_division: entier représente le nombre des interval de division de la base de données (par exemple 3)

k_voisin : entier représente le nombre des voisins le plus proche pour knn

distance : string représente la distance utilise (entrer la commande 'help knn' pour trouve les différentes distance disponible )

les sorties :

Tct : c'est le tau de classification moyenne des tuax de classifications des changement des intervall 

Set : c'est Sensibilité moyenne

Spt : c'est la spécificité moyenne

c :  c'est la matrice de confusion de taux de classification le plus grand 

exemple :  exemple : [t, se, sp] = knnTp1('Pima.txt', 3, 9, 'euclidean');

la fonction knnTp1.m: pour réaliser le knn sans cross validation .
[Te, Se, Sp, c] = knnTp1(path, k, dist)

path : String représente le directoire de la base de donneés 

k: entier représente le nombre des voisines les plus proches 

dist: String représent la distance knn utilisé 

sorties :
Te: tau de classifcation 

Se : la sensibilité 

Sp : le spécificité 

c : la matrice de confusion 

exemple : [t, se, sp] = knnTp1('Pima.txt', 9, 'euclidean')
