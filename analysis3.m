%% Peaks of I.F.
figure(25)
lowP_E = max(Eavg-Estd);
p1 = plot(tw,wz); hold on
ylimts = ylim;
NB=length(nb);
for n=1:NB
    plot([tw(nb(n)) tw(nb(n))],[ylimts(1) ylimts(2)],'r')
end
[pks, locs] = findpeaks(wz, 'MinPeakDistance', 2000, 'MinPeakHeight', lowP_E);
p2 = plot(locs/SR, pks, 'o'); hold off
legend([p1,p2],'IF','Peaks');
axis tight
title('Peaks of Instantaneous Frequency','FontSize',24);
xlabel('Time(s)','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);

%% Envelope of I.F.
figure(26)
pp = pchip (locs/SR, pks,tw);
plot(tw(nb(2):nb(end)),wz(nb(2):nb(end))); hold on
plot(tw(nb(2):nb(end)),pp(nb(2):nb(end)));
legend('IF','Envelpoe');
hold off
axis tight
title('Instantaneous Frequency and its envelope','FontSize',24);
xlabel('Time(s)','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);

%% Superimposed envelope and REP
figure(27)
zmpp = pp(nb(2):nb(end)) - mean(pp(nb(2):nb(end)));
[hAx,hLine1,hLine2] = plotyy(tw(nb(2):nb(end)),zmpp,tw(nb(2):nb(end)),zmsrpe(nb(2):nb(end)));
xlim(hAx(1),[tw(nb(2)) tw(nb(end))]);
xlim(hAx(2),[tw(nb(2)) tw(nb(end))]);
ylim(hAx(1), 'auto');
ylim(hAx(2), 'auto');
title('Envelope of Instantaneous Frequency and Respiratation signal','FontSize',24);
xlabel('Time(s)','FontSize',18);
ylabel(hAx(1),'Frequency(Hz)','FontSize',18);
ylabel(hAx(2),'Thermistor(mV)','FontSize',18);

%% FFT of envelope
figure(29)
subplot(2,2,1)
plot(k,abs(fzmrpe)); grid on; grid minor
xlim([0 2]);
title('Respiration signal in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18); 
ylabel('Magnitude','FontSize',18)
subplot(2,2,3)
pfzmrpe = unwrap(angle((fzmrpe)));
plot(k, pfzmrpe); grid on; grid minor
xlim([0 2]);
xlabel('Hz','FontSize',18); 
ylabel('Phass','FontSize',18)
[pk_fr, loc_fr] = max(abs(fzmrpe));
pk_pr = pfzmrpe(loc_fr);

subplot(2,2,2)
fzmpp = fft(zmpp);
Npp = length(zmpp);
kpp = (0:Npp-1)*SR/Npp;
plot(kpp,abs(fzmpp)); grid on; grid minor
xlim([0 2]);
title('Envelope in frequency domain','FontSize',24);
xlabel('Hz','FontSize',18);
ylabel('Magnitude','FontSize',18)
subplot(2,2,4)
pfzmpp = unwrap(angle(fzmpp));
plot(kpp, pfzmpp); grid on; grid minor
xlim([0 2]);
xlabel('Hz','FontSize',18); 
ylabel('Phass','FontSize',18)
[pk_fe, loc_fe] = max(abs(fzmpp));
pk_pe = pfzmpp(loc_fe);



