% Ensemble average
Nperid = round((nb(end)-nb(1))/(NB-1));
ensemble = zeros(NB-1, Nperid+1);
for i=1:NB-1
    ensemble(i,:)=(wz(nb(i):nb(i)+Nperid));
end
[Eavg, Estd, Eminavg, Eminstd, Emin, k_del] = chc_min_se_ensemble_2(ensemble);