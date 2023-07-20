function out = newCochleagram(inputSignal,fs,frameLength,frameShift)
frameSize = floor((frameLength/1000)*fs);
overlapSize = floor((frameShift/1000)*fs);
[numSamples, numChannels] = size(inputSignal);
numFrames = floor((numSamples-frameSize)/overlapSize+1)+1;

frames = zeros(numChannels,frameSize,numFrames);
for ii = 1:numChannels
    frames(ii,:,:) = buffer(inputSignal(:,ii),frameSize,frameSize-overlapSize,'nodelay');
end

out = squeeze(sum(frames.^2,2));
end

