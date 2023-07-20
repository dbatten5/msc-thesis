function [out] = mono(inputSignal)
if size(inputSignal,2) == 1
    out = inputSignal;
else
    out = sum(inputSignal, 2) / size(inputSignal, 2);
end