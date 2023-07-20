function outSignal = stripSound(inputSignal,fs,buffer)
if nargin < 3
    buffer = 500;
end
idxs = detectSpeech(inputSignal,fs);
for buff = buffer:-100:0
    startIdx = idxs(1,1);
    endIdx = idxs(end,2);
    if startIdx - 1 < buff || numel(inputSignal) - endIdx < buff
        continue
    end
    outSignal = inputSignal(startIdx-buff:endIdx+buff); 
    break
end
end
