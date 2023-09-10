function BER = SISO
% SISO - Simulate Bit Error Rate (BER) for a SISO communication system

% Taking Inputs from user
bits = input('Enter the number of bits: ');       % Number of bits in data
snr0 = input('Enter the initial SNR (Signal-to-Noise Ratio): ');      % Initial SNR (e.g., 0 dB)
snr1 = input('Enter the final SNR: ');        % Final SNR (e.g., 10 dB)

x = round(rand(1, bits));                      % Generating random data bits (0 or 1)

% Modulation to NRZ (Non-Return-to-Zero) or BPSK (Binary Phase Shift Keying)
Tx = (x < 1);                                  % Convert binary data to NRZ/BPSK
Tx = 1 * sqrt(1) * (x - Tx) / sqrt(1);         % Scale the signal

BER = zeros(1, snr1 - snr0 + 1);               % Initialize Bit Error Rate array
n = 1/sqrt(2) * (randn(1, length(Tx)));        % Generate white Gaussian noise (0 dB variance)

for i = snr0:snr1
    Tnx = Tx + 10^(-i/20) * n;                % Add AWGN (Additive White Gaussian Noise)
    Rx = ge(Tnx, 0);                          % Decision for detection (Thresholding)
    ber = sum(xor(x, Rx));                    % Calculate Bit Error Rate
    BER(i - snr0 + 1) = ber;                  % Store BER for this SNR value
end

BER = BER / length(x);                         % Normalize BER by the number of bits
semilogy(snr0:snr1, BER, '-*k', 'linewidth', 2, 'Markersize', 8); % Plot BER vs. SNR
grid on
legend('SISO - AWGN')                        % Add legend for the plot
xlabel('(SNR) Signal - to - Noise Ratio (db)')                           % Label for the x-axis
ylabel('Bit Error Rate (BER)')               % Label for the y-axis
title('BER vs. SNR - SISO AWGN')             % Title for the plot


end