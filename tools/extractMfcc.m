function mfccFeature = extractMfcc(signal,fs)
[coeffs, delta, ddelta, ~] = mfcc(signal,fs);
mfccFeature = [coeffs(:);delta(:);ddelta(:)];
end

