function mfccFeature = extractMfcc(audio,fs,mfccLength,bandEdges)
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

if isstring(bandEdges) && bandEdges == "max"
    [coeffs,delta,ddelta,~] = mfcc(paddedSignal,fs,"BandEdges",linspace(50,fs/2,120));
elseif isvector(bandEdges) && size(bandEdges,2) >= 4
    [coeffs,delta,ddelta,~] = mfcc(paddedSignal,fs,"BandEdges",bandEdges);
else
    [coeffs,delta,ddelta,~] = mfcc(paddedSignal,fs);
end

mfccFeature = [reshape(coeffs',1,[]),reshape(delta',1,[]),reshape(ddelta',1,[])];
end

