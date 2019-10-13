function [features, labels, personIndex] = FeatureExtraction(data, detector, method)

counter = 1;
notdetect = 1;

switch method
    case 'HOG'
        for i=1:size(data, 2) % 1 to 50
            for j=1:data(i).Count % 1 to 12
                normalise = rgb2gray(read(data(i),j));
                histogram = histeq(normalise);
                features(counter,:) = extractHOGFeatures(histogram);
                labels{counter} = data(i).Description;
                fprintf('Subject:%i image:%i\n',i, j);
                counter = counter + 1;
            end
            personIndex{i} = data(i).Description;
        end
    
    case 'LBP'
        for i=1:size(data, 2) % 1 to 50
            for j=1:data(i).Count % 1 to 12
                bbox = step(detector, read(data(i),j)); % Bounding box around detected face
                %bbox = step(faceDetector, image);

                if ~isempty(bbox) % If a face is detected crop & normalise
                    crop = imcrop(read(data(i),j),bbox); % Crop face with bounding box
                    normalise = rgb2gray(crop); % Greyscale
                    histogram = histeq(normalise); % Histogram equalization
                    resize = imresize(histogram,[150 150]);
                    features(counter,:) = extractLBPFeatures(resize);
                else
                    notdetect = notdetect + 1; % Else feature extraction on whole image
                    normalise = rgb2gray(read(data(i),j));
                    histogram = histeq(normalise);
                    features(counter,:) = extractLBPFeatures(histogram);
                end
                labels{counter} = data(i).Description;
                fprintf('Subject:%i image:%i\n',i, j);
                counter = counter + 1;
            end
            personIndex{i} = data(i).Description;
        end
end
end