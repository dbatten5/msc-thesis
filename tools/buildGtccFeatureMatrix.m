function featureMatrix = buildGtccFeatureMatrix(birdID,gtccLength,NVA)
arguments
birdID
gtccLength = 18
NVA.Type = 'train'
NVA.SampleLimit = false
NVA.FreqRange = false
end
directoryPath = sprintf('samples/%s/syllables/%s',birdID,NVA.Type);
fileList = dir(fullfile(directoryPath, '*.wav'));
if sampleLimit
    limit = sampleLimit;
else
    limit = numel(fileList);
end
featureMatrix = zeros(limit,gtccLength*14*3);
for ii = 1:limit
    filePath = fullfile(directoryPath, fileList(ii).name);
    [syllable, fs] = audioread(filePath);
    if NVA.FreqRange 
        featureMatrix(ii,:) = extractGtcc(syllable,fs,gtccLength,NVA.FreqRange);
    else
        featureMatrix(ii,:) = extractGtcc(syllable,fs,gtccLength);
    end
end
end

