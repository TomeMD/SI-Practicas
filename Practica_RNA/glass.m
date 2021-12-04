clear all;
entradas = xlsread('glass.xlsx', 'Entradas RNA')';
salidasDeseadas = xlsread('glass.xlsx', 'Salidas RNA')';

arquitecturas = {[], [4], [7], [10], [12], [15], [20], [5 3], [8 3], [8 5], [10 5]};

for i=1:length(arquitecturas),
    arquitectura = arquitecturas{i};
    precisionEntrenamiento = [];
    precisionValidacion = []; 
    precisionTest = []; 

    for j=1:50,
        rna = patternnet(arquitectura);
        rna.trainParam.showWindow = false;
        [rna, tr] = train(rna, entradas, salidasDeseadas);
        salidas = sim(rna, entradas);
    
        precisionEntrenamiento(end+1) = 1-confusion(salidasDeseadas(:,tr.trainInd), salidas(:,tr.trainInd));
        precisionValidacion(end+1) = 1-confusion(salidasDeseadas(:,tr.valInd), salidas(:,tr.valInd));
        precisionTest(end+1) = 1-confusion(salidasDeseadas(:,tr.testInd), salidas(:,tr.testInd)); 
    end;
    
    fprintf('Arquitectura [%s], Entrenamiento: %.2f%% (%.2f), Validacion: %.2f%% (%.2f), Test: %.2f%% (%.2f)\n', num2str(arquitectura), mean(precisionEntrenamiento).*100, std(precisionEntrenamiento), mean(precisionValidacion).*100, std(precisionValidacion), mean(precisionTest).*100, std(precisionTest));
end;
