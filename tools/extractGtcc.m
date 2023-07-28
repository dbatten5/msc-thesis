function gtccFeature = extractGtcc(audio,fs,gtccLength,freqRange)
if nargin < 4
    freqRange = [50 fs/2];
end

sigLength = size(audio,1);
winLength = fs*0.03;
overlapLength = fs*0.02;

paddedSignalLength = (gtccLength - 1) * (winLength - overlapLength) + winLength;

if sigLength < paddedSignalLength
    paddedSignal = zeros(paddedSignalLength,1);
    paddedSignal(1:sigLength) = audio;
else
    paddedSignal = audio(1:paddedSignalLength);
end

[coeffs,delta,ddelta,~] = gtcc(paddedSignal,fs,'FrequencyRange',freqRange);

gtccFeature = [reshape(coeffs',1,[]),reshape(delta',1,[]),reshape(ddelta',1,[])];
end
