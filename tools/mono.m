function [out] = mono(inputSignal)
if size(inputSignal,2) == 1
    out = inputSignal;
else
    out = mean(inputSignal,2);
end