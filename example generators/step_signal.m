function [sig] = step_signal()

bands = [250 125];
fs = 5000;
dt = 1/fs;
t = dt:dt:5;
sig = 0;
map = zeros(500, length(t));

map(bands(2), 2.5*fs:end) = 1;
comp = sin(2*pi*bands(2)*t);
comp(2.5*fs:end) = 0;
sig = sig+comp;

map(bands(1), 1:2.5*fs) = 1;
comp = sin(2*pi*bands(2)*t);
comp(1:2.5*fs) = 0;
sig = sig+comp;

figure();
% imagesc(flipud(map));

pcolor(map);
yticks([0:50:500]);
yticklabels([0:50:500])
xticks([0:0.3125:2.5+0.3125]*1e4);
xticklabels([0:0.5:4])
shading interp
xlabel('Time (secs)')
ylabel('Frequency (Hz)')
title('Ideal Spectrum')