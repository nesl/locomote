freqInThousands = 10;
passband = 500;
file_str = string(freqInThousands) + 'k.wav';
[y,Fs] = audioread("D:\Audio_Data_Hydrophone\" + file_str);

%freqInThousands = freqInThousands / 2; % some >20kHz signals are being aliased as 1/2 of the correct frequency

t =  bandpass(y,[freqInThousands*1000-passband,freqInThousands*1000+passband],Fs);

%t = bandpass(y, [100, 100000],Fs); % extend passband to >100Hz

plot(t(100:end-100));