function [out] = mono(inputSignal)
out = sum(inputSignal, 2) / size(inputSignal, 2);
end