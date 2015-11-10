function [stdev] = calculateStandardDeviation(x)
%%Calculates Standard Deviation of the elements present in vector
%x
    n = length(x);
    mean = sum(x)/n;
    stdev = sqrt(sum((x-mean).^2)/n);
end