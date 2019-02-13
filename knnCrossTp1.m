function [Tct, Set, Spt, c] = knnCrossTp1(path, num_division, k_voisin, distance)

    %la fonction knncrossTp1.m: pour réaliser le knn avec le cross validation .
    %
    %[Tct, Set, Spt, c] = knnCrossTp1(path, num_division, k_voisin, distance);
    %
    %les entrées :
    %
    %path: Strign représente le directoire de la base de données 
    %
    %num_division: entier représente le nombre des interval de division de la base de données (par exemple 3)
    %
    %k_voisin : entier représente le nombre des voisins le plus proche pour knn
    %
    %distance : string représente la distance utilise (entrer la commande 'help knn' pour trouve les différentes distance disponible )
    %
    %les sorties :
    %
    %Tct : c'est le tau de classification moyenne des tuax de classifications des changement des intervall 
    %
    %Set : c'est Sensibilité moyenne
    %
    %Spt : c'est la spécificité moyenne
    %
    %c :  c'est la matrice de confusion de taux de classification le plus grand 

    %exemple :  exemple : [t, se, sp] = knnTp1('Pima.txt', 3, 9, 'euclidean');

    warning('off','all');
    %chargement de la base de données 
    bdd = load(path);
    num_rows_bdd = size(bdd, 1);
    num_cols_bdd = size(bdd, 2);
    num_rows_in_division = round(num_rows_bdd/num_division);
    Tt=0;
    Set=0;
    Spt=0;
    n=0;
    maxTc = 0;
    
    for i=1:num_rows_in_division:num_rows_bdd
        
        %verification pour eviter le cas ou le nombre de lines a prendre
        %supieur a nombre de line dans le partie reste 
        if(size(i:num_rows_bdd, 2)>num_rows_in_division)
            
            %c'est la fine de partie qui commence de la début de la base
            %juqu'a la début de partie de test 
            end_part1 = i-1;
            
            %c'est la début de le partie qui commence de la fine de partie 
            %de test jusqu'a la fine de la base 
            start_part2 = i+num_rows_in_division;
            
            %partie (1/num_division) de test 
            bddTest = bdd(i:i+num_rows_in_division-1, 1:num_cols_bdd-1);
            bddTestClass = bdd(i:i+num_rows_in_division-1, num_cols_bdd);            
            
            %la prtie d'apprentissage (le reste de la base de données )
            bddApp(1:end_part1, 1:num_cols_bdd-1) = bdd(1: end_part1, 1:num_cols_bdd-1);
            bddApp(end_part1+1:end_part1+size(start_part2:num_rows_bdd, 2), 1:num_cols_bdd-1) = bdd(start_part2:num_rows_bdd, 1:num_cols_bdd-1);
            bddAppClass(1:end_part1,1) = bdd(1: end_part1, num_cols_bdd);
            bddAppClass(end_part1+1:end_part1+size(start_part2:num_rows_bdd, 2), 1)= bdd(start_part2:num_rows_bdd, num_cols_bdd);
        else
            bddTest = bdd(i:num_rows_bdd, 1:num_cols_bdd-1);
            bddTestClass = bdd(i:num_rows_bdd, num_cols_bdd);
            bddApp = bdd(1: i-1, 1:num_cols_bdd-1);
            bddAppClass = bdd(1: i-1, num_cols_bdd);
        end

        %classification
        result = knnclassify(bddTest, bddApp, bddAppClass, k_voisin, distance);
        cp = classperf(bddTestClass, result);
        Tc = cp.CorrectRate;
        Se = cp.Sensitivity;
        Sp = cp.Specificity;
        Tt = Tt+Tc;
        Set = Set+Se;
        Spt = Spt+Sp;
        n=n+1;
        if(Tc >= maxTc)
            maxTc = Tc;
            [c, order] = confusionmat(bddTestClass, result);
        end
    end
    Tct=Tt/num_division;
    Set = Set/num_division;
    Spt = Spt/num_division;
    c = c;
    order = order;
end