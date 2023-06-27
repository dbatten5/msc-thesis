function out = mrcg(audio,fs)
cochlea1 = log10(cochleagram(audio, fs*0.020, fs*0.010));
cochlea2 = log10(cochleagram(audio, fs*0.200, fs*0.010));
cochlea3 = avg_window(cochlea1, 11);
cochlea4 = avg_window(cochlea1, 23);
out = [cochlea1; cochlea2; cochlea3; cochlea4];
end

function avg = avg_window(data,span)
kernel = ones(span) / span^2;
avg = conv2(data, kernel, 'same');
end