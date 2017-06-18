%% chc_Rwave.m
% R wave peak detection
% CHC (08/12/16)

function nb = Rwave(ECG)

% ns = sampling frequency, nd = distance from the first r-wave peak
e = ECG;
ns = 5000;
nd = 1000;

[~,nmax] = max(e(1:ns));
j = 1;
nb = [];
nb(j) = nmax;

% find rest of the peaks
while nb(j)+nd+ns < length(e);
    nstart = nb(j)+nd;
    nend = nstart+ns;
    [~,nmax] = max(e(nstart:nend));
    j = j+1;
    nb(j) = nmax+nstart-1;
end
end
