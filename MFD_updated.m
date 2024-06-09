%%% MFD 
close all;
clear all;
clc;

%% Initialization
K = 10^4;    % Number of Monte carlo iterations
N = 8;     % Number of symbols
Pfa = [0:0.05:1];    % Range for Probability of False Alarm
snr_dB = [-10:5:5]; % SNR in dB
snr = 10.^(snr_dB./10);
a = 2;
s = 2*randi([0,1],N,1)-1;  % Independent BPSK modulated symbols (Deterministic and known)
x = a*s;
Ex = x'*x;
varw = Ex./snr;          % Noise variance


%% Signal detection
for ii = 1:length(snr_dB)
    for kk = 1:K
        w = sqrt(varw(ii))*randn(N,1); 
        y = x+w; % Received signal
        d0_y(kk) = x'*w;          % Test Statistic under H_0
        d1_y(kk) = x'*y;          % Test Statistic under H_1
    end
    %%% Performance
    gamma = sqrt(Ex*varw(ii))*qfuncinv(Pfa); %Threshold value
    for jj = 1:length(gamma)
        Pfa_sim(ii,jj) = length(find(d0_y>gamma(jj)))/K; % Probability of false alarm simulated
        Pd_sim(ii,jj) = length(find(d1_y>gamma(jj)))/K; % Probability of detection simulated
    end
    Pd_th(ii,:) = qfunc(qfuncinv(Pfa)-sqrt(snr(ii))); % Probability of detection analytical     
end

%% Figures
hold on;
grid on;
plot(Pfa, Pd_th(1,:),'b-','LineWidth',3);
plot(Pfa_sim(1,:), Pd_sim(1,:),'bo','MarkerFaceColor','b','MarkerSize',10);
plot(Pfa, Pd_th(2,:),'m--','LineWidth',3);
plot(Pfa_sim(1,:), Pd_sim(2,:),'m >','MarkerFaceColor','m','MarkerSize',10);
plot(Pfa, Pd_th(3,:),'k:','LineWidth',3);
plot(Pfa_sim(1,:), Pd_sim(3,:),'k s','MarkerFaceColor','k','MarkerSize',10);
plot(Pfa, Pd_th(4,:),'g-.','LineWidth',3);
plot(Pfa_sim(1,:), Pd_sim(4,:),'g ^','MarkerFaceColor','g','MarkerSize',10);
xlabel('Probability of False Alarm (P_{FA})')
ylabel('Probability of Detection (P_D)')
legend('Analytical ROC (SNR: -10dB)','Simulated ROC (SNR: -10dB)','Analytical ROC (SNR: -5dB)','Simulated ROC (SNR: -5dB)','Analytical ROC (SNR: 0dB)','Simulated ROC (SNR: 0dB)','Analytical ROC (SNR: 5dB)','Simulated ROC (SNR: 5dB)','Location','southeast')
title(' Matched Filter for Sensing')