function [sig] = test_wave_1()

bands = [40 80 120 150 180 250 300 350 650 950];
fs = 5000;
dt = 1/fs;
t = dt:dt:5;
sig = 0;
map = zeros(1000, length(t));
for i =1:length(bands)
    map(bands(i), :) = 1;
    comp = sin(2*pi*bands(i)*t);
    comp(1*fs:1.2*fs) = 0;
    map(bands(i), 1*fs:1.2*fs) = 0;
    pt = 1*fs + randi(length(t)-1.2*fs);
    comp(pt:pt+0.2*fs) = 0;
    map(bands(i), pt:pt+0.2*fs) = 0;
    sig = sig+comp;
end
figure();
imagesc(flipud(map));
yticks([0:100:1000]);
yticklabels([1000:-100:0])