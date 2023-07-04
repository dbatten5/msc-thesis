function outSig = addNoise(signal,noise,snr)
noise = noise(1:numel(signal));
sigPower = rms(signal)^2;
noisePower = rms(noise)^2;
desiredNoisePower = sigPower / (10^(snr/10));    
noise = sqrt(desiredNoisePower/noisePower)*noise;
outSig = signal+noise;
end