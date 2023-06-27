function out = cochleagram(in, winLength, winShift)
[sigLength, numChan] = size(in);

M = floor(sigLength/winShift);
increment = winLength / winShift;

out = zeros(numChan, M);

for m = 1:M
    for i = 1:numChan
        if m < increment
            out(i,m) = in(1:m*winShift,i)'*in(1:m*winShift,i);
        else
            startpoint = floor((m-increment)*winShift);
            to = floor(startpoint+winLength);
            out(i,m) = in(startpoint+1:to,i)'*in(startpoint+1:to,i);
        end
    end
end
end