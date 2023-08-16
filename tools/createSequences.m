function [sequences,fsMatrix] = createSequences(birdID,type,nva)
arguments
birdID
type = "train"
nva.MaxLengthS = 0.3
nva.MaxSamplesPerBird = inf
end

sampleIDs = getUniqueFilenames(birdID);
syllableDirectoryPath = sprintf('samples/%s/syllables_new/%s',birdID,type);
syllableFileList = dir(fullfile(syllableDirectoryPath, '*.wav'));
syllableFileNames = {syllableFileList.name};

sequences = {};
fsMatrix = {};

for id = sampleIDs
    sampleSequences = {};
    sampleFs = {};

    pattern = ['^', char(id), '_\d+\.wav$'];
    matchingSyllableFilenames = syllableFileNames(~cellfun(@isempty, regexp(syllableFileNames, pattern)));
    sortFunction = @(x) sscanf(x, [char(id),'_%d.wav']);
    [~, sortedIndices] = sort(cellfun(sortFunction, matchingSyllableFilenames));
    matchingSyllableFilenames = matchingSyllableFilenames(sortedIndices);

    if isempty(matchingSyllableFilenames)
        continue
    end

    exhausted = false;
    for jj = 1:numel(matchingSyllableFilenames)
        if exhausted
            break
        end
        fullSignal = [];
        kk = 0;
        while true
            if jj+kk > numel(matchingSyllableFilenames)
                exhausted = true;
                break
            end
            filePath = fullfile(syllableDirectoryPath, matchingSyllableFilenames{jj+kk});
            [syllable, fs] = audioread(filePath);
            maxLength = nva.MaxLengthS * fs;
            fullSignal = [fullSignal;syllable];
            if numel(fullSignal) >= maxLength
                break
            end
            kk = kk+1;
        end
        if length(fullSignal) >= maxLength
            fullSignal = fullSignal(1:maxLength);
            sampleSequences = [sampleSequences;{fullSignal}];
            sampleFs = [sampleFs;{fs}];
        end
        if length(sampleSequences) >= nva.MaxSamplesPerBird
            break
        end
    end

    sequences = vertcat(sequences,sampleSequences);
    fsMatrix = vertcat(fsMatrix,sampleFs);
end
end

function sampleIDs = getUniqueFilenames(birdType)
directoryPath = sprintf('samples/%s/raw',birdType);
fileList = dir(directoryPath);
filenames = {fileList(~[fileList.isdir]).name};
[~, filenames, ~] = cellfun(@fileparts, filenames, 'UniformOutput', false);
sampleIDs = unique(filenames);
sampleIDs = sampleIDs(~cellfun(@isempty, sampleIDs));
end