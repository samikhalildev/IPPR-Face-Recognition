function [features, labels, personIndex] = FeatureExtraction(data, method)

counter = 1;
switch method
    case 'HOG';
        for i=1:size(data, 2) % 1 to 50
            for j=1:data(i).Count % 1 to 12
                %if DATABASE / IMAGE IS RGB
                %normalise = rgb2gray(read(data(i),j));
                %histogram = histeq(normalise);
                %else
                histogram = histeq(read(data(i),j));
                features(counter,:) = extractHOGFeatures(histogram);
                labels{counter} = data(i).Description;
                fprintf('Subject:%i image:%i\n',i, j);
                counter = counter + 1;
            end
            personIndex{i} = data(i).Description;
        end
    
    case 'LBP';
        for i=1:size(data, 2) % 1 to 50
            for j=1:data(i).Count % 1 to 12
                %if DATABASE / IMAGE IS RGB
                %normalise = rgb2gray(read(data(i),j));
                %[a1] = (normalise);
                %meanIntensity = mean(a1(:));
                %a1_binary = a1 > meanIntensity;
                %features(counter,:) = extractLBPFeatures(a1_binary);
                
                %else
                features(counter,:) = extractLBPFeatures(read(data(i),j));
                labels{counter} = data(i).Description;
                fprintf('Subject:%i image:%i\n',i, j);
                counter = counter + 1;
            end
            personIndex{i} = data(i).Description;
        end
end

