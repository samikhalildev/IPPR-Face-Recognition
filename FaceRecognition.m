
%% Getting Data

%%% 50 subjects each with 15 images
database = imageSet('Data/gt_db', 'recursive');

%%% training data contains 12 images per subject
%%% testing data contains 3 images per subject
[trainingData, testingData] = partition(database, [0.8 0.2]); 

%% Feature Extraction

%%% HOG - this seems to take a while, other techniques to try KNN OR CNN
counter = 1;
for i=1:size(trainingData, 2) % 1 to 50
    for j=1:trainingData(i).Count % 1 to 12
        features(counter,:) = extractHOGFeatures(read(trainingData(i),j));
        labels{counter} = trainingData(i).Description;
        fprintf('Subject:%i image:%i\n',i, j);
        %imshow(read(trainingData(i),j));
        counter = counter + 1;
    end
    personIndex{i} = trainingData(i).Description;
end

%% Training Model
model = fitcecoc(features, labels);

%% Predict Model
% predictedValue = predict(model, queryFeature);

