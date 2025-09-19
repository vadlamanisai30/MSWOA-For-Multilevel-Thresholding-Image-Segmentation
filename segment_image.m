function segmented_img = segment_image(img, thresholds)
    thresholds = sort(round(thresholds));
    segmented_img = zeros(size(img));
    levels = [0; thresholds(:); 256];

    for i = 1:length(levels) - 1
        mask = img >= levels(i) & img < levels(i+1);
        segmented_img(mask) = mean([levels(i), levels(i+1)]);
    end
end
