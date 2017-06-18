%% Previous ver. Hilbert
SR = 5000;
W = 1001;

by_old = hilbert(bx);
bz_old = bx + i*by_old;
az_old = abs(bz_old);
pz_old = unwrap(angle(bz_old));

spz_old = sgolayfilt(pz_old,2,W);
[b_old, g_old] = sgolay(2,W);
HW = (W+1)/2 - 1;
dif_old = zeros(1,N);
for n = HW+1:N-HW
    dif_old(n) = g_old(:,2)'*spz_old(n-HW:n+HW)';
end

dstart_old = ones(1,HW)*dif_old(HW+1);
dif_old(1:HW) = dstart_old;
dend_old = ones(1,HW)*dif_old(N-HW);
dif_old(N-HW+1:N) = dend_old;

wz_old = dif_old*SR/(2*pi);
tw = (0:length(wz_old)-1)/SR;

save('previous.mat');

%% Current ver. Hilbert
clear variables

by_new = hilbert(bx);
bz_new = by_new;
az_new = abs(bz_new);
pz_new = unwrap(angle(bz_new));

spz_new = sgolayfilt(pz_new,2,W);
[b_new, g_new] = sgolay(2,W);
HW = (W+1)/2 - 1;
dif_new = zeros(1,N);
for n = HW+1:N-HW
    dif_new(n) = g_new(:,2)'*spz_new(n-HW:n+HW)';
end

dstart_new = ones(1,HW)*dif_new(HW+1);
dif_new(1:HW) = dstart_new;
dend_new = ones(1,HW)*dif_new(N-HW);
dif_new(N-HW+1:N) = dend_new;

wz_new = dif_new*SR/(2*pi);

save('current.mat');

%%
load('previous.mat');

figure
plot(tw,wz_old); hold on
plot(tw,wz_new); hold off
axis tight
legend('previous','current');
title('Superimposed Instantaneous Frequency','FontSize',24);
xlabel('Time (s)','FontSize',24);
ylabel('Frequency (Hz)','FontSize',24);
%% Angle (unwrapped) of the Hilbert transform

figure
subplot(2,1,1)
plot(tw(28620:28640),wz_old(28620:28640)); hold on
plot(tw(28620:28640),wz_new(28620:28640)); hold off
axis auto
legend('previous','current');
title('Sections of superimposed Instantaneous Frequency','FontSize',24);
xlabel('Time (s)','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
subplot(2,1,2)
plot(tw(77540:77590),wz_old(77540:77590)); hold on
plot(tw(77540:77590),wz_new(77540:77590)); hold off
axis auto
legend('previous','current');
xlabel('Time (s)','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);

figure
plot(wz_new(1001:end-1000) - wz_old(1001:end-1000))
axis([1001 149093 -0.001 0.001])
title('Amplitude difference of current and previous instantaneous frequencies','FontSize',24);
xlabel('Sample number','FontSize',18);
ylabel('Difference','FontSize',18);

error = rms(wz_new(1001:end-1000) - wz_old(1001:end-1000));

figure
subplot(2,2,1)
plot(tw,pz_new);hold on
plot(tw,pz_old);hold off
axis tight; grid on
title('Unwrapped angle','FontSize',24)
legend('current','previous','Location','SouthEast');
xlabel('Time (s)','FontSize',18);
ylabel('Unwrapped angle (rad)','FontSize',18);
subplot(2,2,2)
plot(tw(67050:67300),pz_new(67050:67300));hold on
plot(tw(67050:67300),pz_old(67050:67300));hold off
axis tight; grid on
title('Zoom-in on unwrapped angle','FontSize',24)
legend('current','previous','Location','SouthEast');
xlabel('Time (s)','FontSize',18);
ylabel('Unwrapped angle (rad)','FontSize',18);

subplot(2,2,3)
plot(tw,spz_new);hold on
plot(tw,spz_old);hold off
axis tight; grid on
title('Smoothed unwrapped angle','FontSize',24)
legend('current','previous','Location','SouthEast');
xlabel('Time (s)','FontSize',18);
ylabel('Unwrapped angle (rad)','FontSize',18);
subplot(2,2,4)
plot(tw(67050:67300),spz_new(67050:67300));hold on
plot(tw(67050:67300),spz_old(67050:67300));hold off
axis tight; grid on
title('Zoom-in on smoothed unwrapped angle','FontSize',24)
legend('current','previous','Location','SouthEast');
xlabel('Time (s)','FontSize',18);
ylabel('Unwrapped angle (rad)','FontSize',18);