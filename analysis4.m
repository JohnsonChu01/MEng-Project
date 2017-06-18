%% Determine outliers
[outlier_High, high] = findpeaks(wz, 'MinPeakHeight', max(Eavg+Estd)+2);
[outlier_Low, low] = findpeaks(-wz, 'MinPeakHeight', -min(Eavg-Estd)+2);
outlier_Low = -outlier_Low;

figure(42); % point the outliers and normals
plot(tw,wz); hold on
ylimits = ylim;
for i = 2:4:10
    plot([tw(nb(i)) tw(nb(i))],[ylimits(1) ylimits(2)],'r');
    plot([tw(nb(i+1)) tw(nb(i+1))],[ylimits(1) ylimits(2)],'r');
end
plot([tw(high-850) tw(high-850)],[ylimits(1) ylimits(2)],'r');
plot([tw(high+850) tw(high+850)],[ylimits(1) ylimits(2)],'r');
plot([tw(low(1)-850) tw(low(1)-850)],[ylimits(1) ylimits(2)],'r');
plot([tw(low(1)+850) tw(low(1)+850)],[ylimits(1) ylimits(2)],'r');
plot([tw(low(2)-850) tw(low(2)-850)],[ylimits(1) ylimits(2)],'r');
plot([tw(low(2)+850) tw(low(2)+850)],[ylimits(1) ylimits(2)],'r');
axis tight; hold off

text(tw(high+850),ylimits(2)-0.4,'\leftarrow outlier3','FontSize',18);
text(tw(low(1)+850),ylimits(1)+1,'\leftarrow outlier1','FontSize',18);
text(tw(low(2)+850),ylimits(1)+1.4,'\leftarrow outlier2','FontSize',18);
text(tw(nb(3)),ylimits(2)-0.4,'\leftarrow normal 1', 'FontSize',18);
text(tw(nb(7)),ylimits(2)-1,'\leftarrow normal 2', 'FontSize',18);
text(tw(nb(11)),ylimits(2)-1.4,'\leftarrow normal 3', 'FontSize',18);
title('Instantaneous Frequency and outliers','FontSize',24);
xlabel('Time (s)','FontSize',24);
ylabel('Frequency (Hz)','FontSize',24);

%% Checking amplitude of the outliers
figure(43)
subplot(2,3,1)
plot(bz(low(1)-750:low(1)+750));
legend('Outlier 1');
axis([-0.01 0.01 -0.01 0.01],'equal') 
xlabel 'Real'; ylabel 'Imaginary';
grid on 
subplot(2,3,2)
plot(bz(low(2)-750:low(2)+750));
legend('Outlier 2');
title('Hilber transform of the outlier waves','FontSize',24);
axis([-0.01 0.01 -0.01 0.01],'equal')
xlabel 'Real'; ylabel 'Imaginary';
grid on 
subplot(2,3,3)
plot(bz(high-750:high+750));
legend('Outlier 3');
axis([-0.01 0.01 -0.01 0.01],'equal')
xlabel 'Real'; ylabel 'Imaginary';
grid on 

subplot(2,3,4)
plot(bz(nb(2):nb(2)+Nperid));
legend('Normal 1');
axis([-0.01 0.01 -0.01 0.01],'equal')
xlabel 'Real'; ylabel 'Imaginary';
grid on 
subplot(2,3,5)
plot(bz(nb(6):nb(6)+Nperid));
legend('Normal 2');
axis([-0.01 0.01 -0.01 0.01],'equal')
title('Hilber transform of the normal waves','FontSize',24);
xlabel 'Real'; ylabel 'Imaginary';
grid on 
subplot(2,3,6)
plot(bz(nb(10):nb(10)+Nperid));
legend('Normal 3');
axis([-0.01 0.01 -0.01 0.01],'equal')
xlabel 'Real'; ylabel 'Imaginary';
grid on 

%% Ensemble after elimination
ensembleT = ensemble;
for i=1:NB-(length(high)+length(low))
    if min(ensembleT(i,:)) < min(outlier_Low)+0.1 || max(ensembleT(i,:)) > min(outlier_High)-0.1
        ensembleT(i,:)=[];
    end
end

[eli_Eavg, eli_Estd, eli_Eminavg, eli_Eminstd, eli_Emin, eli_k_del] = chc_min_se_ensemble_2(ensembleT);

%% Ensemble average before and after
figure(44)
subplot(1,2,1)
plot (Eavg,'k','LineWidth',1.5); hold on; grid on
axis tight
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
title('Origional ensemble average','FontSize',24);
plot(Eavg+Estd,'k--','LineWidth',1.5);
plot(Eavg-Estd,'k--','LineWidth',1.5);
hold off
subplot(1,2,2)
plot (Eminavg,'k','LineWidth',1.5); hold on; grid on
axis tight
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
title(' Ensemble average after outlier elimination','FontSize',24);
plot(eli_Eavg+eli_Estd,'k--','LineWidth',1.5);
plot(eli_Eavg-eli_Estd,'k--','LineWidth',1.5);
hold off
