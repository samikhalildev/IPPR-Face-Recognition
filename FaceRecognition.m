%% Getting Data

%%% 50 subjects each with 15 images
database = imageSet('Data/gt_db', 'recursive');
%database = imageSet('Data/att_faces', 'recursive');

%%% training data contains 12 images per subject
%%% testing data contains 3 images per subject
[trainingData, testingData] = partition(database, [0.8 0.2]); 


%% Face detection
detector = vision.CascadeObjectDetector;
detector.MinSize = [135 135];


%% Feature extraction
featureExtractionMethod = 'HOG';
[features, trainingLabels, personIndex] = FeatureExtraction(trainingData, detector, featureExtractionMethod);


%% Training Model
fprintf('Training\n');

trainingMethod = 'SVM';
[model] = Models(features, trainingLabels, trainingMethod);

%% Testing Model
fprintf('Testing\n');
person = 1;
queryImage = read(testingData(person), 1);
[queryFeatures, truelabel, index] = FeatureExtraction(testingData, detector, featureExtractionMethod);
predictedLabel = predict(model, queryFeatures);
predictedLabel = predictedLabel'
fprintf('Query\n')
booleanIndex = strcmp(predictedLabel, truelabel);
integerIndex = find(booleanIndex);


%% Create Confusion Matrix
cm = confusionmat(truelabel,predictedLabel);

% Evaluate Model
[Accuracy, Precision, Recall, F1_score] = Evaluate(cm);
