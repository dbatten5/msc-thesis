function mrcgFeature = extractMrcg(filterBank,signal,fs,cochleagramLength)
if nargin < 4
    cochleagramLength = 22;
end

padSamples = cochleagramLength*fs*0.01;

if numel(signal) < padSamples
    paddedSignal = ones(padSamples,1);
    paddedSignal(1:numel(signal)) = signal;
    signal = paddedSignal;
else
    signal = signal(1:padSamples);
end

audioOut = filterBank(signal);
mrcgFeatureMatrix = mrcg(audioOut,fs);
mrcgFeature = reshape(mrcgFeatureMatrix',1,[]);
end

