
%% Getting Data

%%% 50 subjects each with 15 images
database = imageSet('Data/gt_db', 'recursive');

%%% training data contains 12 images per subject
%%% testing data contains 3 images per subject
[trainingData, testingData] = partition(database, [0.8 0.2]); 


%% Face detection
detector = vision.CascadeObjectDetector;
detector.MinSize = [135 135];


%% Feature extraction
featureExtractionMethod = 'LBP';
[features, labels, personIndex] = FeatureExtraction(trainingData, detector, featureExtractionMethod);


%% Training Model
fprintf('Training\n');
trainingMethod = 'SVM';
[model] = Models(features, labels, trainingMethod);


%% Testing Model
fprintf('Testing\n');
person = 1;
queryImage = read(testingData(person), 1);

[queryFeatures, label, index] = FeatureExtraction(testingData, detector, featureExtractionMethod);
personLabel = predict(model, queryFeatures);

booleanIndex = strcmp(personLabel, personIndex);
integerIndex = find(booleanIndex);

imshow(queryImage);title('query');
imshow(read(training(integerIndex), 1));title('matched');
