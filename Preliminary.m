% Preliminary Analysis
% this code is to analysis the delay in thermistor.

[Filename, Pathname] = uigetfile('.\project data/081216/*.txt'); % import the data
PRE = load([Pathname '/' Filename]);
Tname = [Filename(1:11) 'TMP.txt'];
TMP = load([Pathname '/' Tname]);
figure(1);
plot(TMP);
a = ginput(2);
nstart = round(a(1,1));
nstop = round(a(2,1));
tmp = TMP(nstart:nstop)'; % thermistor data
pre = PRE(nstart:nstop)'; % transducer data

figure;
plot(tmp)
axis tight

Fs = 5000; % sampling rate.
W = 1001; % smooth funtion window size
stmp = sgolayfilt(tmp,2,W); % smoothing thermistor data
% Identify inhalation points (the maximum points in each cycle)
[pksT,locsT] = findpeaks(stmp,'MinPeakDistance', 3000 ,'MinPeakHeight', 3.59); 
figure
subplot(2,1,1)
t = (0:length(stmp)-1)/Fs;
plot(t(1:15000), stmp(1:15000));
hold on; axis tight
ylabel ('Thermistor (mV)','FontSize',18);
xlabel ('Time (s)','FontSize',18);
title ('Normal Breathing','FontSize',18)
plot(locsT(1:4)/Fs, pksT(1:4),'ro','markers',8);
hold off

NP = length(pksT);
pksP = zeros(1,NP);
locsP = zeros(1,NP);
for i = 1:length(locsT)
    preT = zeros(10,10);
    N = [1,11,21,31,41,51,61,71,81,91];
    for I = 1:10
        preT(:,I) = pre(locsT(i)-(200-N(I)):locsT(i)-(200-N(I)-9));
    end
    Pstd = std(preT);
    k = find(Pstd>0.002,1);
    preT(k*10+1:end) = [];
    % Identify inhalation points (the points at the beginning of the large pressure change)
    [pksP(i), locsP(i)] = max(preT); 
    locsP(i) = locsP(i) + (locsT(i) - 200);
end

subplot(2,1,2)
plot(t(1:15000), pre(1:15000)); 
hold on; axis tight
ylabel ('Transducer (mV)','FontSize',18);
xlabel ('Time (s)','FontSize',18);
plot(locsP(1:4)/Fs, pksP(1:4),'ro','markers',8);
hold off

delay = mean(locsT-locsP);
t_delay = delay/Fs;

