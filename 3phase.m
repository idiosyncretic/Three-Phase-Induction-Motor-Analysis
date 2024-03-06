% Parameters
R1 = 0.641; % Stator resistance
X1 = 1.106; % Stator reactance
R2 = 0.332; % Rotor resistance
X2 = 0.464; % Rotor reactance
Xm = 26.13; % Magnetizing reactance

% Operating condition
V_phase = 460 / sqrt(3); % Phase voltage
f = 60; % Frequency in Hz
s = 0.02; % Slip

% Impedances
Z1 = R1 + 1j*X1; % Stator impedance
Z2 = R2/s + 1j*X2; % Rotor impedance
Zm = 1j*Xm; % Magnetizing impedance

% Equivalent circuit
Zeq = Z1 + (Z2*Zm) / (Z2 + Zm);

% Currents
I1 = V_phase / Zeq; % Stator current
I2 = V_phase / (Z1 + Z2); % Rotor current

% Torque
Pout = 3 * abs(I2)^2 * R2 / s; % Output power
T = Pout / (2*pi*f); % Torque

fprintf('Stator current: %f A\n', abs(I1));
fprintf('Rotor current: %f A\n', abs(I2));
fprintf('Output power: %f W\n', Pout);
fprintf('Torque: %f Nm\n', T);
% Time vector
t = linspace(0, 1/f, 1000);

% Phase currents
I1_phase = abs(I1) * sqrt(2) * sin(2*pi*f*t + angle(I1));
I2_phase = abs(I2) * sqrt(2) * sin(2*pi*f*t + angle(I2) - 2*pi/3);
I3_phase = abs(I2) * sqrt(2) * sin(2*pi*f*t + angle(I2) + 2*pi/3);

% Plot
figure;
plot(t, I1_phase, 'r', 'LineWidth', 2); hold on;
plot(t, I2_phase, 'g', 'LineWidth', 2);
plot(t, I3_phase, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Current (A)');
title('Three-Phase Currents');
legend('Phase 1', 'Phase 2', 'Phase 3');
grid on;
