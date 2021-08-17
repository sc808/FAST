function [meanPower, f] = fil_agg_v2(sig, bands, sampRate, order)

%format for powers is [f1 f2 f3 f4 f5]
%bands will be from f1 to f2, f2 to f3, ...

%% Alignment
dt = 1/sampRate;
if size(sig,1)>1
    d = sig';
else
    d = sig ;
end

if size(bands,1)>1
    bands = bands';
end
signal = d;

%%

sampleT = 1:size(signal,2);
[sig_sst, sig_f] = wsst(sig, sampRate);
meanPower = zeros(size(sig_sst));
f = sig_f;

parfor i = 1:size(bands,2)-2
    try
        f1 = bands(1,i);
        f2 = bands(1,i+1);
        
        bandedge = 1.5;
        
        if f1 - bandedge  < 1
            filband1 = 1;
        else
            filband1 = f1 - bandedge;
        end
        filband2 = f1 + bandedge +1;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fil_band = designfilt('bandpassiir','FilterOrder',order, ...
            'DesignMethod','butter', ...
            'HalfPowerFrequency1',filband1,'HalfPowerFrequency2',filband2, ...
            'SampleRate',sampRate);
        
        signal_fil = filtfilt(fil_band, signal);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        [sst, f] = wsst(signal_fil, sampRate);
        %         [sst, f] = cwt(signal_fil, sampRate);
        
        disp(f1)
        meanPower = meanPower + sst;
    catch
        disp("Error in band :")
        disp(f1)
        disp(f2)
        disp("--------")
        continue
    end
end

%% Masking

mask = abs(sig_sst)>0.9*mean(mean(abs(sig_sst)));

final = meanPower.*mask;
%% plotting

figure;
if max(sampleT/(sampRate*60))<=1
    hp = pcolor(sampleT/(sampRate),f,abs(mask));
    hp.EdgeColor = 'none';
    cl = colorbar;
    cl.Label.String = 'magnitude';
    xlabel('Time(s)'); ylabel('Hz');
    title('Mask')
else
    hp = pcolor(sampleT/(sampRate*60),f,abs(mask));
    hp.EdgeColor = 'none';
    cl = colorbar;
    cl.Label.String = 'magnitude';
    xlabel('Time(mins)'); ylabel('Hz');
    title('Mask')
end

figure;
if max(sampleT/(sampRate*60))<=1
    hq = pcolor(sampleT/(sampRate),f,abs(meanPower));
    hq.EdgeColor = 'none';
    cl = colorbar;
    cl.Label.String = 'magnitude';
    xlabel('Time(s)'); ylabel('Hz');
    title('Pre-mask')
else
    hq = pcolor(sampleT/(sampRate*60),f,abs(meanPower));
    hq.EdgeColor = 'none';
    cl = colorbar;
    cl.Label.String = 'magnitude';
    xlabel('Time(mins)'); ylabel('Hz');
    title('Pre-mask')
end

figure;
if max(sampleT/(sampRate*60))<=1
    hr = pcolor(sampleT/(sampRate),f,abs(final));
    hr.EdgeColor = 'none';
    cl = colorbar;
    cl.Label.String = 'magnitude';
    xlabel('Time(s)'); ylabel('Hz');
    title('FAST')
else
    hr = pcolor(sampleT/(sampRate*60),f,abs(final));
    hr.EdgeColor = 'none';
    cl = colorbar;
    cl.Label.String = 'magnitude';
    xlabel('Time(mins)'); ylabel('Hz');
    title('FAST')
end

% figure
% hp = pcolor(sampleT/fs,sig_f,abs(sig_sst));
% hp.EdgeColor = 'none';
% xlabel('Time(s)'); ylabel('Hz');
% title('Original')

end