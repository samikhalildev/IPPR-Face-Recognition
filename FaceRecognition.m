
%% Getting Data
DatabaseChoice = menu('Choose a Database','Georgia Tech','FERET','ATT');
switch DatabaseChoice
    case 1
        database = imageSet('Data/gt_db', 'recursive');
    case 2
        database = imageSet('Data/FERET', 'recursive');
    case 3
        database = imageSet('Data/att_faces', 'recursive');
end


ExtractorChoice = menu('Choose a Feature Extractor','HOG','LBP');

switch ExtractorChoice
    case 1
        featureExtractionMethods = 'HOG';
    case 2
        featureExtractionMethods = 'LBP';
end


ClassifierChoice = menu('Choose a Classifier','SVM','KNN','Decision Trees');

switch ClassifierChoice
    case 1
        trainingMethod = 'SVM';
    case 2
        trainingMethod = 'KNN';
    case 3
        trainingMethod = 'D-TREE';
end


%%% training data contains 80% of data
%%% testing data contains 20% of data
[trainingData, testingData] = partition(database, [0.8 0.2]); 


%% Feature extraction
fprintf('Extracting features\n');
[features, trainingLabels, personIndex] = FeatureExtraction(trainingData, featureExtractionMethods);


%% Training classifer 
fprintf('Training\n');
[model] = Models(features, trainingLabels, trainingMethod);


%% Testing Model
fprintf('Testing\n');

figure;
figureNum = 1;

predicted = [];
real = [];

for person=1:5
    for j = 1:testingData(person).Count
        queryImage = read(testingData(person), j);
        
        [queryFeatures] = TestFeatureExtraction(queryImage, featureExtractionMethods);
        predictedLabel = predict(model, queryFeatures);

        booleanIndex = strcmp(predictedLabel, personIndex);
        integerIndex = find(booleanIndex);
        
        predicted(j, person) = integerIndex;
        real(j, person) = person;

        subplot(2,2,figureNum);imshow(imresize(queryImage,3));title('Query image:');        
        subplot(2,2,figureNum+1);imshow(imresize(read(trainingData(integerIndex),j),3));title('Matched Class');
        figureNum = figureNum + 2;
    end
    figure;
    figureNum = 1;
end


%% Create Confusion Matrix

pred = [];
realA = [];

for i=1:size(real,1)
    pred = [pred, predicted(i,:)];
    realA = [realA, real(i,:)];
end

confmat = confusionmat(realA, pred);


%% Evaluate Model
[Accuracy, Precision, Recall, F1_score] = Evaluate(confmat);
