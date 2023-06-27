function plotMrcg(audio,fs,titleText)
mrcgFeatures = mrcg(audio, fs);
imagesc(mrcgFeatures);
colormap jet
colorbar
ylabel('Feature dimension')
xlabel('Frame index')
title(sprintf('%s MRCG',titleText))
set(gca,'YDir','normal')
end