function [ bbox ] = getFaceBoundingBox(A, print)

    faceDetector = vision.CascadeObjectDetector();
    bbox = step(faceDetector, A);
    if print
    B = insertObjectAnnotation(A,'rectangle',bbox,'Face');
    figure, imshow(B), title('Detected face');
    end
end

