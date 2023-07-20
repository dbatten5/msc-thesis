function [syllables, maxSyllableLength] = segmentSyllables(inputSignal,fs,frameSizeMs,mergeThreshMs,minimumSyllableThreshMs)
%SEGMENTSYLLABLES Summary of this function goes here
%   Detailed explanation goes here
if size(inputSignal,2) > 1
    inputSignal = mono(inputSignal);
end

if nargin < 3
    frameSizeMs = 3;
    mergeThreshMs = 15;
    minimumSyllableThreshMs = 5;
end

if nargin < 4
    mergeThreshMs = 15;
    minimumSyllableThreshMs = 5;
end

if nargin < 5
    minimumSyllableThreshMs = 5;
end

frameSize = floor((frameSizeMs/1000)*fs);
overlapSize = frameSize/2;
frames = buffer(inputSignal,frameSize,overlapSize,'nodelay');

window = hann(frameSize);
windowedFrames = frames .* window;

energy = sum(windowedFrames.^2,1);
energyDb = 10 * log10(energy);
% normalize to 0db
energyDb = energyDb - max(energyDb);

initNoiseDb = min(energyDb);
initThreshDb = initNoiseDb/2;
numFrames = size(windowedFrames,2);

noiseDb = initNoiseDb;
threshDb = initThreshDb;
onsets = zeros(1,numFrames);
offsets = zeros(1,numFrames);
sigMarkers = zeros(1,numFrames);
sigMarker = false;
for i = 1:numFrames
    if energyDb(1,i) > threshDb
        sigMarkers(i) = 1;
        if ~sigMarker
            onsets(i) = 1;
            sigMarker = true;
        end
    else
        if sigMarker
            offsets(i) = 1;
            sigMarker = false;
        else
            if i > 1
                processedNonSyllableFrames = find(~sigMarkers(:,1:i-1));
                noiseDb = mean(energyDb(processedNonSyllableFrames));
                threshDb = noiseDb/2;
            end
        end
    end
end

% syllable merging
mergeThreshFrames = (mergeThreshMs*2)/frameSizeMs;
mergedSm = sigMarkers;
mergedOff = offsets;
mergedOns = onsets;

onsetIndices = find(onsets);
offsetIndices = find(offsets);
% if same number of offsets as onsets then we can ignore last offset
if numel(onsetIndices) == numel(offsetIndices)
    offsetIndices = offsetIndices(1:end-1);
end
syllableDists = onsetIndices(2:end)-offsetIndices;
mergeCandidateIndices = find(syllableDists <= mergeThreshFrames);
for ii = mergeCandidateIndices
    oi = offsetIndices(ii);
    ol = oi+syllableDists(ii);
    mm = oi:ol;
    mergedSm(mm) = 1;
    mergedOff(oi) = 0;
    mergedOns(ol) = 0;
end

markedSamples = zeros(size(inputSignal));
for ii = find(mergedSm)
    ss = (ii - 1) * overlapSize + 1;
    se = ss + frameSize - 1;
    markedSamples(ss:se) = 1;
end

maxSyllableLength = 0;
syllableBoundaries = find(diff(markedSamples) ~= 0) + 1;
minimumSyllableThreshFrames = minimumSyllableThreshMs * fs / 1000;
syllables = {};
for ii = 1:2:numel(syllableBoundaries)
    if ii+1 > numel(syllableBoundaries)
        break
    end
    st = syllableBoundaries(ii);
    en = syllableBoundaries(ii+1);
    if en-st < minimumSyllableThreshFrames
        continue
    end
    if en-st > maxSyllableLength
        maxSyllableLength = en-st;
    end
    syllables = [syllables;{inputSignal(st:en)}];
end

end

