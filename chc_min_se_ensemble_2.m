% chc_min_se_ensemble_2.m  -  find the subset of an ensemble that gives minimum SE
% CHC (08/06/17) - based on min_se_ensemble_2.m

function [Eavg, Estd, Eminavg, Eminstd, Emin, k_del] = chc_min_se_ensemble_2(E)
% E (N,T)       = the original ensemble of waveforms
% Emin (Nmin,T) = the subset that gives minimum SE

plotflag = 1;        % change to 0 to suppress plots
sizeE = size(E);
if (sizeE(1) > sizeE(2))
    E = E';
end
[N, T]=size(E);
% calculate ensemble average
Eavg = mean(E);
Estd = std(E);
% calculate corr coeffs
c_e = zeros(1,N);
a_e = Eavg-mean(Eavg);
for n = 1:N
    b_e = E(n,:)-mean(E(n,:));
    c_e(n) = (b_e*a_e')/sqrt((b_e*b_e')*(a_e*a_e'));
end

% order beats by corr
[c_e_sort, k_sort]=sort(c_e); % sort corr coeffs in ascending order
E_sort=E(k_sort,:); % sort E by corr coeff

% calculate min se omitting lowest corr beats from ensenble
for n = 1:N-10 % i.e. minimum number of beats in ensemble = 10
    E_se(n) = mean(std(E_sort(n:end,:)))/sqrt(N-n);
end
[E_se_min, k_min] = min(E_se);
Emin = E_sort(k_min:end,:);
if (k_min==1)
    k_del = [];
else
    k_del = k_sort(1:k_min-1);
end

if plotflag
    Eminavg = mean(Emin);
    Eminstd = std(Emin);
    % diagnostic plot of usd_corr
    figure(125); clf;
    subplot(1,3,1);
%     plot(E');
    grid on; hold on;
    plot(Eavg,'k','LineWidth',2);
    plot(Eavg+Estd,'k--','LineWidth',2);
    plot(Eavg-Estd,'k--','LineWidth',2); 
    axis tight
    stitle = ['full ensemble, ' num2str(N) ' intervals'];
    title(stitle,'FontSize',18);
    ylabel 'Frequency (HZ)';
    xlabel 'sample number';
    subplot(1,3,3);
%     plot(Emin');
    grid on; hold on;
    plot(Eminavg,'k','LineWidth',2);
    plot(Eminavg+Eminstd,'k--','LineWidth',2);
    plot(Eminavg-Eminstd,'k--','LineWidth',2); 
    axis tight
    Nmin = size(Emin,1);
    stitle = ['min SE ensemble, ' num2str(Nmin) ' intervals'];
    title(stitle,'FontSize',18);
    ylabel 'Frequency (HZ)';
    xlabel 'sample number';
    subplot(1,3,2);
    n = (1:N-10); m=N-n+1;
    plot(m,E_se,'ko-'),grid on;
    ylabel 'SE';
    xlabel 'beats in ensemble';
    title('standard error','FontSize',18);
end
