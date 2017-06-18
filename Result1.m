%% Ensemble average of all I.F.
figure
plot (Eavg1,'LineWidth',1.5);hold on; grid on
plot (Eavg2,'LineWidth',1.5)
plot (Eavg3,'LineWidth',1.5)
plot (Eavg4,'LineWidth',1.5)
plot (Eavg5,'LineWidth',1.5)
plot (Eavg6,'LineWidth',1.5)
legend('rest 1', 'rest 2', 'mild exercise 1', 'mild exercise 2', 'heavy exercise 1', 'heavy exercise 2');
axis tight
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
title('Ensemble averages for each experimental setting','FontSize',24);
%%
figure
subplot(2,3,1)
x1 = 1:length(Eavg1);
y1(1,:) = Eavg1 + Estd1;
y1(2,:) = Eavg1 - Estd1;
px1 = [x1,fliplr(x1)]; % makes a closed patch
py1 = [y1(1,:), fliplr(y1(2,:))];
plot (Eavg1,'LineWidth',1.5); hold on;
p1 = patch(px1,py1,1,'FaceColor','b','EdgeColor','none');
title('Rest 1', 'FontSize',18)
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
ylim([172 176])
xlim([0 4100])
grid on
alpha(.2);
subplot(2,3,4)
x2 = 1:length(Eavg2);
y2(1,:) = Eavg2 + Estd2;
y2(2,:) = Eavg2 - Estd2;
px2 = [x2,fliplr(x2)]; % makes a closed patch
py2 = [y2(1,:), fliplr(y2(2,:))];
plot (Eavg2,'LineWidth',1.5); hold on;
p2 = patch(px2,py2,1,'FaceColor','r','EdgeColor','none');
title('Rest 2', 'FontSize',18);
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
ylim([172 176])
xlim([0 4100])
grid on
alpha(.2);
subplot(2,3,2)
x3 = 1:length(Eavg3);
y3(1,:) = Eavg3 + Estd3;
y3(2,:) = Eavg3 - Estd3;
px3 = [x3,fliplr(x3)]; % makes a closed patch
py3 = [y3(1,:), fliplr(y3(2,:))];
plot (Eavg3,'LineWidth',1.5); hold on;
p3 = patch(px3,py3,1,'FaceColor','y','EdgeColor','none');
title('Mild Exercise 1', 'FontSize',18)
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
ylim([172 176])
xlim([0 4100])
grid on
alpha(.2);
subplot(2,3,5)
x4 = 1:length(Eavg4);
y4(1,:) = Eavg4 + Estd4;
y4(2,:) = Eavg4 - Estd4;
px4 = [x4,fliplr(x4)]; % makes a closed patch
py4 = [y4(1,:), fliplr(y4(2,:))];
plot (Eavg4,'LineWidth',1.5); hold on;
p4 = patch(px4,py4,1,'FaceColor','m','EdgeColor','none');
title('Mild exercise 2', 'FontSize',18)
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
ylim([172 176])
xlim([0 4100])
grid on
alpha(.2);
subplot(2,3,3)
x5 = 1:length(Eavg5);
y5(1,:) = Eavg5 + Estd5;
y5(2,:) = Eavg5 - Estd5;
px5 = [x5,fliplr(x5)]; % makes a closed patch
py5 = [y5(1,:), fliplr(y5(2,:))];
plot (Eavg5,'LineWidth',1.5); hold on;
p5 = patch(px5,py5,1,'FaceColor','g','EdgeColor','none');
title('Heavy exercise 1', 'FontSize',18)
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
ylim([172 176])
xlim([0 4100])
grid on
alpha(.2);
subplot(2,3,6)
x6 = 1:length(Eavg6);
y6(1,:) = Eavg6 + Estd6;
y6(2,:) = Eavg6 - Estd6;
px6 = [x6,fliplr(x6)]; % makes a closed patch
py6 = [y6(1,:), fliplr(y6(2,:))];
plot (Eavg6,'LineWidth',1.5); hold on;
p6 = patch(px6,py6,1,'FaceColor','c','EdgeColor','none');
title('Heavy exercise 2', 'FontSize',18)
xlabel('sample number','FontSize',18);
ylabel('Frequency (Hz)','FontSize',18);
ylim([172 176])
xlim([0 4100])
grid on
alpha(.2);
