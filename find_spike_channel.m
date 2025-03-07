function [spike_chan_id,spike_event]=find_spike_channel(eeg,chanNames,fs,thr)
%   Find possible pathological channels with spikes.
%   
%   occuerrnce rate > [thr] times of the average spike rate
%   eeg:        miltichannel EEG data in columns.
%   chanNames:  channel labels.
%   fs:         sampling frequency.
%   tr:         threshold to define the spike channels.
%
%   spike_chan_id: spike channels index (monopolar)
%   spike_event:    
   % - column 1: spike channel
   % - column 2: spike time in SAMPLES (not s)
   % - column 3: spike duration in SAMPLES
   % - column 4: spike amplitude in uV
   % - column 5: time (in samples) of the spike relative to its spike train (first
   % spike is 0)

%   Weichen Huang
%   3.7.2025

if nargin<4 %Can change as needed.
    thr = 5;
end
fprintf('%s\n','---- Detecting epileptic spikes ----');

spike_event = clean_detector_test(eeg,fs);
fprintf('---- Done ----')
n_spike = zeros(length(chanNames),1);
for ichan = 1 : length(chanNames)
    n_spike(ichan) = length(find(spike_event(:,1)==ichan));
end

%Channels with event occurence rate > 5*mean rate are shown. 
pc=find(n_spike>thr*mean(n_spike));
spike_chan_id = pc;