% psd_diff_assessment - Computes and plots alpha band (7-13 Hz) differences 
% between Eyes Closed and Eyes Open conditions.
% Input: sub-01*.set files from NEMAR ds004148
% Output: Topoplot of spectral power differences and saved figure.
% Author: Maggie Zhang, Date: 2025-06-20


% Load datasets
EEG_open = pop_loadset('sub-01_ses-session1_task-eyesopen_eeg.set');
EEG_closed = pop_loadset('sub-01_ses-session1_task-eyesclosed_eeg.set');

% Set electrode labels to standard positions to ensure correct orientation
EEG_open = pop_chanedit(EEG_open, 'lookup','standard-10-5-cap385.elp'); 
EEG_closed = pop_chanedit(EEG_closed, 'lookup','standard-10-5-cap385.elp');

% Find common channels
[common, idx_open, idx_closed] = intersect({EEG_open.chanlocs.labels}, ...
    {EEG_closed.chanlocs.labels});

% Parameters
freqRange = [7, 13]; % Relaxed alpha band
n = length(common);

% Initialize arrays
psd_open_db = zeros(n, 1);
psd_closed_db = zeros(n, 1);

% Channel processing by loop
for i = 1:n
    % Eyes open
    [psd_db, freq] = spectopo(EEG_open.data(idx_open(i),:), 0, ...
        EEG_open.srate, ...
        'plot', 'off');
    freqIdx_open = freq >= freqRange(1) & freq <= freqRange(2);
    psd_open_db(i) = mean(psd_db(freqIdx_open));
    % Eyes closed
    [psd_db, freq] = spectopo(EEG_closed.data(idx_closed(i),:), 0, ...
        EEG_closed.srate, ...
        'plot', 'off');
    freqIdx_closed = freq >= freqRange(1) & freq <= freqRange(2);
    psd_closed_db(i) = mean(psd_db(freqIdx_closed));
end

% Calculate differences (should be positive)
powerDiff_db = max(psd_closed_db - psd_open_db, 0);

% Create figure
figure

% Plot dB difference
topoplot(powerDiff_db, EEG_open.chanlocs(idx_open), ...
        'maplimits', 'minmax', ...
        'electrodes', 'on', ...
        'style', 'both');

% Add title and font color customizations
t = 'sub-01: Alpha Power Difference (Eyes Closed - Eyes Open)';
h_title = title({t}, ...
    'Color', 'k', ... 
    'FontWeight', 'bold');
h_colorbar = colorbar;
h_colorbar.Color = 'k';                 

% Save figure
saveas(gcf, 'Topoplot.png')


