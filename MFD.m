%%% MFD 
close all;
clear all;
clc;

%% Initialization
K = 10^4;    % Number of Monte carlo iterations
N = 8;       % Number of symbols
Pfa = [10^-5, 10^-3, 10^-2, 10^-1];    % Range for Probability of False Alarm
snr_dB = [0:2:20];             % SNR values in dB
snr = 10.^(snr_dB./10);
a = 2;
s = ((2*randi([0,1],N,1))-1);  % Independent BPSK modulated symbols (Deterministic and known)
x = a*s;
Ex = x'*x;
varw = Ex./snr;          % Noise variance


%% Signal detection
for ii = 1:length(snr_dB)
    for kk = 1:K          % Monte carlo iterations
        w = sqrt(varw(ii))*randn(N,1);  
        y = x+w;          % Received signal
        T(kk) = x'*y;     % Test Statistic under H_1
    end
    %%% Performance
    gamma = sqrt(Ex*varw(ii))*qfuncinv(Pfa);         %  Threshold value
    for jj = 1:length(gamma)
        Pd_sim(ii,jj) = length(find(T>gamma(jj)))/K;  % Probability of detection simulated
    end
    Pd_th(ii,:) = qfunc(qfuncinv(Pfa)-sqrt(snr(ii)));% Probability of detection analytical     
end

%% Figures
hold on;
grid on;
plot(snr_dB, Pd_th(:,1),'g-','LineWidth',3);
plot(snr_dB, Pd_sim(:,1),'g^','MarkerFaceColor','g','MarkerSize',10);
plot(snr_dB, Pd_th(:,2),'k:','LineWidth',3);
plot(snr_dB, Pd_sim(:,2),'ko','MarkerFaceColor','k','MarkerSize',10);
plot(snr_dB, Pd_th(:,3),'b-.','LineWidth',3);
plot(snr_dB, Pd_sim(:,3),'b>','MarkerFaceColor','b','MarkerSize',10);
plot(snr_dB, Pd_th(:,4),'m--','LineWidth',3);
plot(snr_dB, Pd_sim(:,4),'m s','MarkerFaceColor','m','MarkerSize',10);
xlabel('SNR(dB)=10log_{10}({E_x}/{\sigma^2_w})')
ylabel('Probability of Detection (P_D)')
legend('Analytical (P_{FA}: 10^{-5})','Simulated (P_{FA}: 10^{-5})','Analytical (P_{FA}: 10^{-3})','Simulated (P_{FA}: 10^{-3})','Analytical (P_{FA}: 10^{-2})','Simulated (P_{FA}: 10^{-2})','Analytical (P_{FA}: 10^{-1})','Simulated (P_{FA}: 10^{-1})','Location','southeast')
title(' Matched Filter Detector')