%% Getting Data

%database = imageSet('Data/gt_db', 'recursive');
%database = imageSet('Data/FERET', 'recursive');
database = imageSet('Data/att_faces', 'recursive');


%%% training data contains 80% of data
%%% testing data contains 20% of data

[trainingData, testingData] = partition(database, [0.8 0.2]); 


%% Feature extraction
% HOG, LBP
%Extractor

featureExtractionMethod = 'HOG';
%featureExtractionMethod ='LBP';

fprintf('Extracting\n');
[features, trainingLabels, personIndex] = FeatureExtraction(trainingData, featureExtractionMethod);


%% Training Model
% SVM, KNN, D-TREE, N-BAYES
%Classifier        

%trainingMethod = 'SVM';
trainingMethod = 'KNN';
%trainingMethod = 'D-TREE';

fprintf('Training\n');
[model] = Models(features, trainingLabels, trainingMethod);

%% Testing Model
fprintf('Testing\n');
person = 1;
queryImage = read(testingData(person), 1);
[queryFeatures, truelabel, index] = FeatureExtraction(testingData, featureExtractionMethod);
predictedLabel = predict(model, queryFeatures);
predictedLabel = predictedLabel'
fprintf('Query\n')
booleanIndex = strcmp(predictedLabel, truelabel);
integerIndex = find(booleanIndex);


%% Create Confusion Matrix
cm = confusionmat(truelabel,predictedLabel);

% Evaluate Model
[Accuracy, Precision, Recall, F1_score] = Evaluate(cm);
