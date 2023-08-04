function featureMatrix = buildMfccFeatureMatrix(birdID,mfccLength,NVA)
arguments
birdID
mfccLength = 18
NVA.Type = 'train'
NVA.SampleLimit = false
NVA.BandEdges = false
end
directoryPath = sprintf('samples/%s/syllables/%s',birdID,NVA.Type);
fileList = dir(fullfile(directoryPath, '*.wav'));
if NVA.SampleLimit
    limit = NVA.SampleLimit;
else
    limit = numel(fileList);
end
featureMatrix = zeros(limit,mfccLength*14*3);
for ii = 1:limit
    filePath = fullfile(directoryPath, fileList(ii).name);
    [syllable, fs] = audioread(filePath);
    featureMatrix(ii,:) = extractMfcc(syllable,fs,mfccLength,NVA.BandEdges);
end
end
