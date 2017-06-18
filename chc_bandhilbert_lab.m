%% chc_bandhilbert_lab.m
% CHC (29/05/17)
% calculate instantaneous frequency of bandpass filtered sound data
% adapted for bandpass specified by user
% assume input data is in row vector, sampling rate = 5000 Hz

SR = 5000;

%load original data and truncate
[Filename, Pathname] = uigetfile('.\data/2008_11_06_sound_ecg/*.txt');
DATA = load([Pathname '/' Filename]);
Ename = [Filename(1:3) 'ECG.txt'];
ECG = load([Pathname '/' Ename]);
Rname = [Filename(1:3) 'RPE.txt'];
RPE = load([Pathname '/' Rname]);

figure(101);
plot(DATA);
a = ginput(2);
nstart = round(a(1,1));
nstop = round(a(2,1));
data = DATA(nstart:nstop)';
ecg = ECG(nstart:nstop)';
rpe = RPE(nstart+207:nstop+207)'; % compensated the delay in thermistor

figure(102);
plot(data)
axis tight

% find peaks of the Rwave from ECG
nb = chc_Rwave(ecg);

% get spectrum of data and determine band stop frequencies
fd = fft(data);
N = length(data);
w = (0:N-1)*SR/N;
figure(103); clf;
plot(w,abs(fd)); xlim([0 1000]); grid on
hold on
f0 = input('center frequency: [400]  ');
if isempty(f0); f0 = 400; end;
fw = input('band width: [100]  ');
if isempty(fw); fw = 100; end;
f0 = 2*f0; fw = 2*fw;
f = [0 f0-fw f0-fw/2 f0+fw/2 f0+fw SR]/SR; 
a = [0 0 1 1 0 0];
b = firls(121,f,a);
[h,wfilt] = freqz(b,1,512);

% filter data
bx = filtfilt(b,1,data);
fbx = fft(bx);
plot(w,abs(fbx),'r')
hold off

% window length
W=1001;

% calculate hilbert transform of filtered data
bz = hilbert(bx);
az = abs(bz);
pz = unwrap(angle(bz));
spz = sgolayfilt(pz,2,W); % smooth pz by Savitzky-Golay FIR smoothing filter
[bs,g] = sgolay(2,W);
HW = (W+1)/2 - 1;
dif = zeros(1,N);
for n = HW+1:N-HW
    dif(n) = g(:,2)'*spz(n-HW:n+HW)'; % 1st order derivative
end
dstart = ones(1,HW)*dif(HW+1);
dif(1:HW) = dstart;
dend = ones(1,HW)*dif(N-HW);
dif(N-HW+1:N) = dend;

wz = dif*SR/(2*pi); % Instantaneous frequescy
tw = (0:length(wz)-1)/SR;
figure(1);
subplot(2,1,1)
plot(tw,wz)
axis tight
hold on

% setup RR interval
ylimits = ylim;
NB = length(nb);
for n=1:NB
    plot([tw(nb(n)) tw(nb(n))],[ylimits(1) ylimits(2)],'r')
end
title('Instantaneous Frequency','FontSize',24);
xlabel('Time (s)','FontSize',24);
ylabel('Frequency (Hz)','FontSize',24);
hold off

% ECG trace
subplot(2,1,2)
plot(tw,ecg); hold on
plot(tw(nb),ecg(nb),'ro'); hold off
title('ECG trace','FontSize',24);
xlabel('Time (s)','FontSize',24);
ylabel('ECG (mV)','FontSize',24);
axis tight


