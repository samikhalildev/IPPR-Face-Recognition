function [model] = Models(trainingFeatures, trainingLabel, method)

switch method
    case 'SVM'
        model = fitcecoc(trainingFeatures,trainingLabel);
    
    case 'KNN'
        model = fitcknn(trainingFeatures,trainingLabel);
    
    case 'D-TREE'
        model = fitctree(trainingFeatures,trainingLabel);

    case 'N-BAYES'
        model = fitcnb(trainingFeatures,trainingLabel);
end
end

