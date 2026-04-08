% Clear workspace
clear; clc; close all;

filename = 'THDandV.xlsx';

% 1. Check if file exists in current folder
if ~isfile(filename)
    error('File "%s" not found. Place it in your MATLAB current folder or provide full path.', filename);
end

% 2. Read data explicitly from Row 3 (skipping headers) to Column K
% Using 'Range' avoids header-parsing errors with merged/formatted cells
try
    data = readmatrix(filename, 'Range', 'A3:K50');
catch ME
    % Fallback for older MATLAB versions (< R2019a) or stubborn Excel formatting
    warning('readmatrix failed. Falling back to xlsread...');
    [~, ~, raw] = xlsread(filename, 'A3:K50');
    data = cell2mat(raw);
end

% 3. Remove any completely empty or NaN rows (common with Excel trailing rows)
data = data(all(~isnan(data), 2), :);

% 4. Extract columns
M = data(:, 1);
THD_data = data(:, [2, 4, 6, 8, 10]);  % THD for 5k, 10k, 15k, 20k, 25k
V_data   = data(:, [3, 5, 7, 9, 11]);  % Voltage for 5k, 10k, 15k, 20k, 25k

freq_labels = {'5 kHz', '10 kHz', '15 kHz', '20 kHz', '25 kHz'};

% ================= PLOT 1: M vs THD =================
figure('Name', 'M vs THD', 'Position', [100, 100, 850, 500]);
hold on; grid on; box on;
colors = lines(5);
for i = 1:5
    plot(M, THD_data(:, i), 'Color', colors(i,:), 'LineWidth', 2, ...
         'Marker', 'o', 'MarkerSize', 6, 'MarkerFaceColor', colors(i,:));
end
xlabel('Modulation Index (M)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Total Harmonic Distortion (THD %)', 'FontSize', 12, 'FontWeight', 'bold');
title('THD vs Modulation Index (M) at Different Switching Frequencies', 'FontSize', 14, 'FontWeight', 'bold');
legend(freq_labels, 'Location', 'best', 'FontSize', 11);

xticks(M);
yticks(0:20:160); 
hold off;

% ================= PLOT 2: M vs Voltage =================
figure('Name', 'M vs Voltage', 'Position', [150, 150, 850, 500]);
hold on; grid on; box on;
for i = 1:5
    plot(M, V_data(:, i), 'Color', colors(i,:), 'LineWidth', 2, ...
         'Marker', 's', 'MarkerSize', 6, 'MarkerFaceColor', 'none');
end
xlabel('Modulation Index (M)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Output Voltage (V)', 'FontSize', 12, 'FontWeight', 'bold');
title('Output Voltage vs Modulation Index (M) at Different Switching Frequencies', 'FontSize', 14, 'FontWeight', 'bold');
legend(freq_labels, 'Location', 'best', 'FontSize', 11);
hold off;

disp('✅ Plots generated successfully!');