hold on

%% original signal

file_str = "23.75k10bps.wav"; % MUST ADJUST
[y,Fs] = audioread(file_str);
freq = 23.75e3; % MUST ADJUST
passband = 500;
bit_rate = 10 / Fs; % MUST ADJUST
symbol_length = 1 / bit_rate;

t =  bandpass(y,[freq-passband,freq+passband],Fs);

plot(t, 'DisplayName', "OOK Signal",'LineWidth',0.3);

%% envelope detection using Hilbert transform
% can use Hilbert transform IIR and FIR filter approximations for a causal version

% Hilbert transform: response to a LTI filter called a Hilbert transformer
% property of linearity
% time domain signal to another time domain signal
% used to obtain the Analytic Signal (only positive frequencies, no
% negative frequency components)
% shifts phase angles of all positive frequency spectral components by -90
% degrees and all negative frequency spectral components by +90 degrees
% doesn't change the magnitude/amplitude, just the phase spectrum

% Analytic Signal Sa(t), signal S(t), hilbert transform `S(t)
% Sa(t) = S(t) + j`S(t)
% Complex representation --> express as exponential via Euler's Formula
% Sa(t) = A(t) e^(j * phi(t))
% A(t) is the instantaneous amplitude (estimate) (local energy)
% phi(t) is the instantaneous phase --> can calculate instantaneous
% frequency
% This instantaneous amplitude measurement describes the envelope of the
% signal --> envelope detection via hilbert transform.


envelope = abs(hilbert(t));

plot(envelope, 'DisplayName', "Envelope",'LineWidth',0.8);

%% low pass filter of detected envelope

filter_strength = 6; % ADJUSTABLE PARAMETER

lpf = lowpass(envelope,filter_strength,Fs,'ImpulseResponse','iir','Steepness',0.95); % iir for better smoothing than fir filter

plot(lpf, 'DisplayName', "LPF of Envelope",'LineWidth',1);


%% convert to sequence of bits

signal_amplitude = 0.09; % MUST ADJUST
bits = signal_amplitude / 2 * (1 + sign(lpf - signal_amplitude));
plot(bits, 'DisplayName', "Baseband Signal",'LineWidth',2);

%% clocking & synchronization for sampling bits
% how to avoid sampling during the bit transitions?
% need to sample in the middle of each bit
% this requires phase synchronization
% for now, do it manually

phase_offset = 0.6e4; % MUST ADJUST ***
num_bits_transmitted = 1210; % MUST ADJUST ***

sample_time = symbol_length / 2 + phase_offset;
sample_points = sample_time + symbol_length * (0:num_bits_transmitted);
xline(sample_points, "HandleVisibility", 'off', 'LineWidth', 0.1);
plot([0 0], 'k', 'DisplayName', 'Sampled Bits');

%% bit sampling
sampled_bits = bits(sample_points);
sampled_bits(sampled_bits > 0) = 1;
% fprintf('sampled_bits: [%s]\n', join(string(sampled_bits), ''));
bit_string = join(string(sampled_bits), '');
disp("Sampled sequence of bits:                 " + bit_string);

%% expected sequence of bits
% 0.1834, simple block encoding
transmitted_sequence = "0000 1010 0001 1000 0011 0100";
transmitted_sequence = strrep(transmitted_sequence, ' ', '');
expected_bits = repmat(transmitted_sequence, 1, floor(num_bits_transmitted / strlength(transmitted_sequence)));
expected_bits = join(expected_bits, '');
disp("Expected sequence of bits:                " + expected_bits);

%% frame matching
% for now, do it manually
bit_offset = 6; % MUST ADJUST ***
frame_matched_bit_string = extractBetween(bit_string, bit_offset + 1, strlength(expected_bits));
disp("Frame-matched sampled sequence of bits:   " + frame_matched_bit_string);

%% calculate bit error rate
% get the count of all bits that don't match

% inefficient, must convert back to char array -- fix it later
frame_matched_bit_array = convertStringsToChars(frame_matched_bit_string);
%disp(frame_matched_bit_array);
expected_bit_array = convertStringsToChars(expected_bits);
expected_bit_array = expected_bit_array(1:length(frame_matched_bit_array));
%disp(expected_bit_array);
bit_error_count = sum(frame_matched_bit_array ~= expected_bit_array);
disp("Number of bit errors: " + bit_error_count);
bit_error_rate = 100 * bit_error_count / num_bits_transmitted;
disp("Bit error rate (BER): " + bit_error_rate + "%");

%% plot settings

legend("show");
title("OOK Signal to Binary Interpretation");
xlabel("Samples (1/Fs)");
ylabel("Signal Amplitude");

hold off