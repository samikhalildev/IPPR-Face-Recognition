
%% Getting Data

%%% 50 subjects each with 15 images
database = imageSet('Data/gt_db', 'recursive');

%%% training data contains 12 images per subject
%%% testing data contains 3 images per subject
[trainingData, testingData] = partition(database, [0.8 0.2]); 

%% Feature Extraction
detector = vision.CascadeObjectDetector();
detector.MinSize = [135 135];

%%% HOG - this seems to take a while, other techniques to try KNN OR CNN
counter = 1;
    for i=1:size(trainingData, 2) % 1 to 50
        for j=1:trainingData(i).Count % 1 to 12
            normalise = rgb2gray(read(trainingData(i),j));
            histogram = histeq(normalise);
            features(counter,:) = extractHOGFeatures(histogram);
            labels{counter} = trainingData(i).Description;
            fprintf('Subject:%i image:%i\n',i, j);
            counter = counter + 1;
        end
        personIndex{i} = trainingData(i).Description;
    end
    
%%%LBP
counter = 1;
notdetect=1;
for i=1:size(trainingData, 2) % 1 to 50
    for j=1:trainingData(i).Count % 1 to 12
        bbox = detector(read(trainingData(i),j)); % Bounding box around detected face
        if ~isempty(bbox) % If a face is detected crop & normalise
            crop = imcrop(read(trainingData(i),j),bbox); % Crop face with bounding box
            normalise = rgb2gray(crop); % Greyscale
            histogram = histeq(normalise); % Histogram equalization
            resize = imresize(histogram,[150 150])
            features(counter,:) = extractLBPFeatures(resize);
        else
            notdetect = notdetect + 1; % Else feature extraction on whole image
            normalise = rgb2gray(read(trainingData(i),j));
            histogram = histeq(normalise);
            features(counter,:) = extractLBPFeatures(histogram);
        end
        labels{counter} = trainingData(i).Description;
        fprintf('Subject:%i image:%i\n',i, j);
        counter = counter + 1;
    end
    personIndex{i} = trainingData(i).Description;
end

%% Training Model
model = fitcecoc(features, labels);

%% Predict Model
% predictedValue = predict(model, queryFeature);

