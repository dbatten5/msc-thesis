function [syllables,fsMatrix] = retrieveSamples(birdID,type,nva)
arguments
birdID
type = "train"
nva.NumConcatSyllables = 1
nva.MaxSamplesPerBird = inf
end

sampleIDs = getUniqueFilenames(birdID);
syllableDirectoryPath = sprintf('samples/%s/syllables_new/%s',birdID,type);
syllableFileList = dir(fullfile(syllableDirectoryPath, '*.wav'));
syllableFileNames = {syllableFileList.name};

syllables = {};
fsMatrix = {};

for id = sampleIDs
    sampleSyllables = {};
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
            fullSignal = [fullSignal;syllable];
            kk = kk+1;
            if kk > nva.NumConcatSyllables-1
                break
            end
        end
        sampleSyllables = [sampleSyllables;{fullSignal}];
        sampleFs = [sampleFs;{fs}];
        if length(sampleSyllables) >= nva.MaxSamplesPerBird
            break
        end
    end

    syllables = vertcat(syllables,sampleSyllables);
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