function [ p ] = saisie( dataChoice )
    if dataChoice == 1
        N= input('Entrez l''ordre de votre polynôme : ');
        disp('Entrez les coefficients du polynôme de haut en bas :');
        pp=[];
        for i=1:N+1
            pp(i) = input(['Coefficient nomber ',num2str(i), ': ']);
        end
    p=pp;
    elseif dataChoice == 2
        N= input('Entrez l''ordre du polynôme : ');
        disp('Entrez les racines du polynôme un par un :');
        zeros =[];
        for i = 1:N
            zeros(i) = input(['Zéro ', num2str(i), ' : ']);
        end
    p=poly(zeros);
    elseif dataChoice == 3
        N = input('Entrez l''ordre de l''interpolation : ');
        disp('Entrez les coordonnées des points (x, y) un par un .');
        points =[];
        x= input(['Entrez les coordonnées de X sous form [X1,X2,X3...Xn] : ']);
        y= input(['Entrez les coordonnées de X sous form [Y1,Y2,Y3...Yn] : ']);
        for i = 1:length(x)
            points(i, 1) = x(i);
            points(i, 2) = y(i);
        end
    p=polyfit(points(:,1),points(:,2),N);
    end
p;    
end

