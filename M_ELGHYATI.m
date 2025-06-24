b=true;
while b
    %Une partie � saisie des donn�es �
    disp('(?�?`?) Bienvenue dans le programme de r�solution de polyn�mes ! (?�?`?)');
    disp('Veuillez choisir le type de donn�es que vous souhaitez fournir :');
    disp('1. �quation explicite du polyn�me');
    disp('2.  Les racines du polyn�me');
    disp('3. Ensemble de points � interpoler');
    validChoice= false;
    while ~validChoice
        dataChoice = input('Entrez votre choix (1, 2 ou 3) : ');
        switch dataChoice
            case {1, 2, 3}
                validChoice = true;
            otherwise
                disp('Choix invalide. Veuillez entrer un choix valide.');
        end
    end
    p=saisie( dataChoice )
    %Une partie � traitement des donn�es �
    polynome = poly2sym(p);
    polynomialStr = char(polynome);
    polynomialZeros = roots(p);
    derivativeCoefficients = polyder(p);
    integralCoefficients = polyint(p);
    % Partie "modification des donn�es"
    D=true;
    while D
        polynomial = poly2sym(p);
        polynomialStr = char(polynomial);
        disp(['L''�quation explicite du polyn�me est : ', polynomialStr]);
        disp('est-ce que vous voulez modifier votre  polyn�me ? :');
        disp('1. Oui');
        disp('2. Non');
        validChoice = false;
        while ~validChoice
            m=input('enter votre choix (1 ou 2) :');
            switch m
                case {1, 2}
                    validChoice = true;
                otherwise
                    disp('Choix invalide. Veuillez entrer un choix valide.');
            end
        end

        if m==1
            disp('Veuillez choisir le type de donn�es que vous souhaitez modifier :');
            disp('1. Modifier les donn�es que vous avez fournies');
            disp('2. remplacer l��quation par celle de sa d�riv�e');
            disp('3. remplacer l��quation par celle de son int�grale ');
            validChoice = false;
            while ~validChoice
                data = input('Entrez votre choix (1, 2 ou 3) : ');
                switch dataChoice
                    case {1, 2, 3}
                        validChoice = true;
                    otherwise
                        disp('Choix invalide. Veuillez entrer un choix valide.');
                end
            end
            if data==1
                p=saisie( dataChoice ); 
            elseif data==2
                p=derivativeCoefficients ;
            elseif data==3
                p=integralCoefficients ;
            end

        elseif m==2
            D=false;
        end

    end
    %affichage des r�sultats
    disp('Donnez-moi le domaine dans lequel vous travaillerez :');
    Xmin = input('Entrez la borne inf�rieure de l''intervalle : Xmin = ');
    Xmax = input('Entrez la borne sup�rieure de l''intervalle : Xmax = ');
    disp('donne-moi ensemble de valeurs x pour lequel vous souhaitez');
    valeurs=input('calculer les valeur du polyn�me sous form [val1 val2..] : ');
    disp('/////////////affichage sous forme textuelle/////////////////// ');
    polynome = poly2sym(p);
    polynomialStr = char(polynome);
    disp(['L''�quation explicite du polyn�me est : ', polynomialStr]);
    polynomialZeros = roots(p);
    disp('Les z�ros du polyn�me sont :');
    disp(polynomialZeros);
    derivativeCoefficients = polyder(p);
    polynomial = poly2sym(derivativeCoefficients);
    derivative = char(polynomial);
    disp(['La d�riv�e du polyn�me est : ', derivative]);
    integralCoefficients = polyint(p);
    polynomial = poly2sym(integralCoefficients);
    integral = char(polynomial);
    disp(['L''int�grale du polyn�me est :' , integral]);
    optima = fminbnd(@(x) -polyval(p, x), Xmin, Xmax);
    disp(['L''optima du polyn�me est atteint � x = ', num2str(optima)]);
    disp('la valeur du polyn�me pour de valeurs x:');
    for i=1:length(valeurs)
                disp(['x= ', num2str(valeurs(i)), ' ---> p(', num2str(valeurs(i)),')=', num2str(polyval(p,valeurs(i)))]);
    end
    disp('/////////////affichage sous forme graphiques/////////////////// ');
    disp('Veuillez choisir le type de donn�es souhait� :');
    disp('1. l�affichage simultan� des 3 sur le m�me graphe');
    disp('2. l�affichage sur 3 fen�tres diff�rentes ');
    disp('3. l�affichage sur 3 graphes diff�rents mais dans la m�me fen�tre');
    validChoice = false;
    while ~validChoice
        dataChoice = input('Entrez votre choix (1, 2 ou 3) : ');
        switch dataChoice
            case {1, 2, 3}
                validChoice = true;
            otherwise
                disp('Choix invalide. Veuillez entrer un choix valide.');
        end
    end
    x = [Xmin:0.001:Xmax];
    y = polyval(p,x);
    y1 = polyval(derivativeCoefficients,x);
    y2 = polyval(integralCoefficients,x);
    y3 = polyval(p,valeurs);
    y4 = polyval(p,optima);
    y5 = polyval(p,polynomialZeros);
    if dataChoice == 1
        grid on
        hold on
        plot(x,y)
        plot(x,y1,'r*')
        plot(x,y2,'g')
        plot(valeurs,y3,'ko')
        plot(optima,y4,'r*')
        plot(polynomialZeros,y5,'c+')
        xlabel('X');
        ylabel('Y');
        title(' P(x)');
        legend('p(x)','p''(x)','integral de p(x)','Xi','optima','les racines');
        hold off
    elseif dataChoice == 2
        figure;
        hold on
        plot(x,y)
        plot(valeurs,y3,'ko')
        plot(optima,y4,'r')
        plot(polynomialZeros,y5,'c+')
        legend('p(x)','Xi','optima','les racines');
        xlabel('X');
        ylabel('Y');
        title(' P(x)');
        hold off
        figure;
        plot(x,y1,'r')
        legend('p''(x)');
        xlabel('X');
        ylabel('Y');
        title(' P''(x)');
        figure;
        plot(x,y2,'g')
        legend('integral de p(x)');
        xlabel('X');
        ylabel('Y');
        title(' integral de p(x)');
    elseif dataChoice == 3
        subplot(3,1,1)
        hold on
        plot(x,y)
        plot(valeurs,y3,'ko')
        plot(optima,y4,'r')
        plot(polynomialZeros,y5,'c+')
        legend('p(x)','Xi','optima','les racines');
        xlabel('X');
        ylabel('Y');
        title(' P(x)');
        hold off
        subplot(3,1,2)
        plot(x,y1,'r')
        legend('p''(x)');
        xlabel('X');
        ylabel('Y');
        title(' P''(x)');
        subplot(3,1,3)
        plot(x,y2,'g')
        legend('integral de p(x)');
        xlabel('X');
        ylabel('Y');
        title(' integral de p(x)');
    end 
    % Demander � l'utilisateur s'il veut �tudier un autre polyn�me ou sorte
    disp('1. Vous souhaitez �tudier un autre polyn�me.');
    disp('2. Vous souhaitez quitter le programme. ');
    validChoice = false;
    while ~validChoice
        dataChoice = input('Entrez votre choix (1 ou 2) : ');
        switch dataChoice
            case {1, 2}
                validChoice = true;
            otherwise
                disp('Choix invalide. Veuillez entrer un choix valide.');
        end
    end
    if dataChoice==1
        continue;
    elseif dataChoice==2
        b=false;
        disp('Programme termin�.?? merci de votre visite');
    end
end