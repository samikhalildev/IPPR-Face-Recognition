%Database
DatabaseChoice = menu('Choose a Database','Georgia Tech','FERET','ATT')
switch DatabaseChoice
    case 1;
        database = imageSet('Data/gt_db', 'recursive');
    case 2;
        database = imageSet('Data/FERET', 'recursive');
    case 3;
        database = imageSet('Data/att_faces', 'recursive');
end

%Extractor
ExtractorChoices = menu('Choose a Feature Extractor','HOGs','LBPs')
switch ExtractorChoice
    case 1;
        featureExtractionMethods = 'HOG'
    case 2;
        featureExtractionMethods ='LBP'
end

%Classifier        
ClassifierChoice = menu('Choose a Classifier','SVM','KNN','Decision Trees')
switch ClassifierChoice
    case 1;
        trainingMethod = 'SVM'
    case 2;
        trainingMethod = 'KNN'
    case 3;
        trainingMethod = 'D-TREE'
end

        
        
