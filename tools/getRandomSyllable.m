function [audio,fs,varargout] = getRandomSyllable(nva)
arguments
    nva.Type = "train"
    nva.BirdID = "all"
end

nout = max(nargout,1) - 1;
allBirds = {"TURMER","LUSMEG"};
allTypes = {"test","train"};

if nva.BirdID == "all"
    birdID = allBirds{randperm(numel(allBirds), 1)};
else
    birdID = nva.BirdID;
end

directoryPath = sprintf('samples/%s/syllables/%s',birdID,nva.Type);
fileList = dir(fullfile(directoryPath, '*.wav'));
syllableFile = fileList(randperm(numel(fileList,1))).name;
filePath = fullfile(directoryPath, syllableFile);

[audio,fs] = audioread(filePath);
audio = mono(audio);

if nargout == 3
    varargout{1} = birdID;
end
end
