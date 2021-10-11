%% create DUT 
H = tf([1 0 (2*pi*1e3)^2],[1 2*pi*1e3 (2*pi*1e3)^2]);
% set testbench parameters
BW = 10e3; % single-sided bandwidth
OSR = 4*2.56; % oversampling ratio
Fs = OSR*BW; % sample rate
%Tsweep = 1; % length of chirp in seconds
%L = Tsweep*Fs; % length of chirp in samples
% No averaging, no windowing, no leakage

%% view analytical response
w = linspace(0,2*pi*BW,1000);
[mag,phz,wout] = bode(H,w);
figure;subplot(211);plot(w/(2*pi),20*log10(squeeze(mag)));grid
title('Magnitude Response');xlabel('Hz');ylabel('dB');
set(gca,'Ylim',[-50 10]);
subplot(212);plot(w/(2*pi),squeeze(phz));grid
title('Phase Response');xlabel('Hz');ylabel('degrees');

%% create excitation for stepped-sine measurement
clear u
f1 = 100;
dF = 50;
f2 = 10e3;
%foi = [100:100:800 900:10:1100 1200:100:10000];
foi = [f1:dF:f2];
N = 4*1024;
t = [0:1/Fs:(N-1)/Fs];
A = 1.1;
for k = 1:length(foi)
    if (A == 1)
        A = 1.1;
    else
        A = 1.0;
    end
    u(1+(k-1)*N:k*N) = A*sin(2*pi*foi(k)*t);
end
t = [0:1/Fs:(length(u)-1)/Fs];



