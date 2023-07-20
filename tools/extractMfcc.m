function mfccFeature = extractMfcc(audio,fs,mfccLength)
sigLength = size(audio,1);
winLength = fs*0.03;
overlapLength = fs*0.02;

paddedSignalLength = (mfccLength - 1) * (winLength - overlapLength) + winLength;

if sigLength < paddedSignalLength
    paddedSignal = zeros(paddedSignalLength,1);
    paddedSignal(1:sigLength) = audio;
else
    paddedSignal = audio(1:paddedSignalLength);
end

[coeffs,delta,ddelta,~] = mfcc(paddedSignal,fs);

mfccFeature = [reshape(coeffs',1,[]),reshape(delta',1,[]),reshape(ddelta',1,[])];
end

