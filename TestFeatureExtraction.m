function [queryFeatures] = TestFeatureExtraction(queryImage, method)

    switch method
        case 'HOG'
            histogram = histeq(queryImage);
            queryFeatures = extractHOGFeatures(histogram);
        case 'LBP'
           queryFeatures = extractLBPFeatures(queryImage);
    end
end