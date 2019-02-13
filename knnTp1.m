function [Te, Se, Sp, c] = knnTp1(path, k, dist)
   
    %la fonction knnTp1.m: pour r�aliser le knn sans cross validation .
    %[Te, Se, Sp, c] = knnTp1(path, k, dist)
    %
    %path : String repr�sente le directoire de la base de donne�s 
    %
    %k: entier repr�sente le nombre des voisines les plus proches 
    %
    %dist: String repr�sent la distance knn utilis� 
    %
    %sorties :
    %Te: tau de classifcation 
    %
    %Se : la sensibilit� 
    %
    %Sp : le sp�cificit� 
    %
    %c : la matrice de confusion 
    %
    %exemple : [t, se, sp] = knnTp1('Pima.txt', 9, 'euclidean')

%%% chargement la base de donn�es %%%
bdd = load(path);
%%%%%%%%%%%%%%%%%%%%%%%%%%%


warning ('off','all');

num_rows_bdd = size(bdd, 1);
    num_cols_bdd = size(bdd, 2);
    
    num_rows_in_division = round(num_rows_bdd/3);
    
    %prendre 1/3 pour le test 
    bddTest = bdd(1:num_rows_in_division, 1:(num_cols_bdd-1));
    bddTestClass = bdd(1:num_rows_in_division, num_cols_bdd);

    
    %prendre le reste pour l'apprentissage c'est-a-dire le (2 ti�re )
    bddApp = bdd(size(bddTest, 1)+1: num_rows_bdd, 1:num_cols_bdd-1);
    bddAppClass = bdd(size(bddTest, 1)+1: num_rows_bdd, num_cols_bdd);


    %classification
    result = knnclassify(bddTest, bddApp, bddAppClass, k, dist);

    
    %evaluation d'experciance 
    cp = classperf(bddTestClass, result);
    Te = cp.CorrectRate;
    Se = cp.Sensitivity;
    Sp = cp.Specificity;
    [c, order] = confusionmat(bddTestClass, result);
    c = c;
    order = order;
end