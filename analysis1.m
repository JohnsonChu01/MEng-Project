%% FFT of instantaneous frequency (zero-mean)
figure(21)
m = mean(wz);
zmwz = wz-m;
fwz=fft(zmwz);
N=length(zmwz);
k=(0:N-1)*SR/N;
plot(k,abs(fwz)); grid on; grid minor
xlim([0 10]);
title('Instantaneous frequency in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18);
ylabel('Magnitude','FontSize',18);

%% Smoothed FFT of instantaneous frequency
mag = abs(fwz);
mag = mag(1:150830);
re_mag = reshape(mag,[10,15083]);
m_mag = sum(re_mag);
s_mag = zeros(1,N);
odd = 1:2:30165;
n = 0:1:15082;
for i = 1:7500
    s_mag(odd(i)*5) = m_mag(odd(i)-n(i));
end
figure 
plot(k,s_mag)
xlim([0 10]); grid on; grid minor
title('Instantaneous frequency in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18);
ylabel('Magnitude','FontSize',18);

%% FFT of ECG (zero-mean)
figure(22)
zme = ecg - mean(ecg);
fzme=fft(zme);
plot(k,abs(fzme)); grid on; grid minor
xlim([0 5]);
title('ECG signal in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18);
ylabel('Magnitude','FontSize',18);

%% FFT of respiration signal (zero-mean)
figure(23)
srpe = sgolayfilt(rpe,2,W); % smoothing respiration signal
zmsrpe = srpe - mean(srpe);
fzmrpe = fft(zmsrpe);
figure(23)
plot(k,abs(fzmrpe)); grid on; grid minor; hold off
xlim([0 5]);
title('Respiration signal in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18);
ylabel('Magnitude','FontSize',18);

%% Subplot FFT of I.F. and respiration
figure(61)
subplot(2,1,1)
plot(k,s_mag); grid on; grid minor; hold on
xlim([0 10]);
title('Instantaneous frequency in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18);
ylabel('Magnitude','FontSize',18);
subplot(2,1,2)
plot(k,abs(fzmrpe)); grid on; grid minor; hold off
xlim([0 5]);
title('Respiration signal in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18);
ylabel('Magnitude','FontSize',18);
%% Superimposing I.F. and REP
figure(24)
tw=(0:length(wz)-1)/SR;
[hAx,hLine1,hLine2] = plotyy(tw,wz,tw,srpe); hold on
hold off
xlim(hAx(1),[0 max(tw)]);
xlim(hAx(2),[0 max(tw)]);
ylim(hAx(1),'auto');
ylim(hAx(2),'auto');
title('Instantaneous Frequency and Respiration signal','FontSize',24);
xlabel('Time (s)','FontSize',18);
ylabel(hAx(1),'Frequency(Hz)','FontSize',18);
ylabel(hAx(2),'Thermistor(mV)','FontSize',18);
