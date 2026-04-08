%% =========================================================
%  M vs THD  &  M vs Voltage  —  SINGLE FREQUENCY
%  Change the data below to match whichever frequency you want.
%  =========================================================

clear; clc; close all;

% -----------------------------------------------------------
% >>>  EDIT THIS SECTION ONLY  <<<
% -----------------------------------------------------------
frequency = '25 kHz';          % Label shown on the plots

M       = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5];
THD     = [29.32
15.02
9.49
7.11
5.65
4.26
3.8
3.26
3
2.66
7.41
7.81
11.32
13.31
15.55

];
Voltage = [32.01
63.88
95.91
127.8
159.8
191.7
223.5
255.5
287.4
319.3
339.9
352.6
361.9
368.8
374.1
];


% -----------------------------------------------------------

figure('Name', ['Carrier Frequency' frequency], 'NumberTitle', 'off', ...
       'Position', [100 300 650 480]);

plot(M, THD, '-o', 'LineWidth', 2, 'MarkerSize', 7, ...
     'Color', [0.85 0.15 0.10], 'MarkerFaceColor', [0.85 0.15 0.10]);

xlabel('Modulation Index  M',  'FontSize', 13, 'FontWeight', 'bold');
ylabel('THD (%)',               'FontSize', 13, 'FontWeight', 'bold');
title(['Carrier Frequecy: ' frequency], 'FontSize', 14, 'FontWeight', 'bold');
grid on;  box on;
xlim([0 1.6]);

xticks(M);
yticks(0:20:160); 
set(gca, 'FontSize', 11);

% ---- M vs Voltage ----
figure('Name', ['Carrier Frequency: ' frequency], 'NumberTitle', 'off', ...
       'Position', [800 300 650 480]);

plot(M, Voltage, '-s', 'LineWidth', 2, 'MarkerSize', 7, ...
     'Color', [0.10 0.45 0.80], 'MarkerFaceColor', [0.10 0.45 0.80]);
hold on;


xlabel('Modulation Index  M',  'FontSize', 13, 'FontWeight', 'bold');
ylabel('Output Voltage (V)',    'FontSize', 13, 'FontWeight', 'bold');
title(['Carrier Frequency:  ' frequency], 'FontSize', 14, 'FontWeight', 'bold');
legend('Measured Voltage', ...
       'Location', 'northwest', 'FontSize', 11);
grid on;  box on;
xlim([0 1.6]);
xticks(M);
set(gca, 'FontSize', 11);
