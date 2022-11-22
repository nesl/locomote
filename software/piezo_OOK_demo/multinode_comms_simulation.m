% can refer to "A Suitable MAC Protocol for Transmit-Only Sensor Nodes in a
% Housing Community Wireless Network" for formula details

hold on;

transmission_window_length = 180; % seconds
propagation_delay = 0.07; % seconds
bit_rate = 2000; % bps

node_counts = [1 2 3 4 5 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200];

reading_frequencies = [1/180 1/60 1/30 1/20 1/10 1/5 1/3 1/2 1 5 10 20 40];



for i = 1:numel(reading_frequencies)
    rf = reading_frequencies(i);
    
    p_failures = [];
    
    packet_length = rf * transmission_window_length * 16;
    slot_count = transmission_window_length / (packet_length * 2 / bit_rate + propagation_delay);
    for j = 1:numel(node_counts)
        nc = node_counts(j);
        p_success = power(((slot_count - 1) / slot_count), (nc - 1));
        
        % probability of EVERY node succeeding, not just one individual
        % node
%         p_success = 1;
%         for k = 1:nc
%             if k > slot_count
%                 break;
%             end
%             p_success = p_success * (slot_count - k)/(slot_count);
%         end
        p_failure = 1 - p_success;
        p_failure = p_failure * 100;
        p_failures = [p_failures, p_failure];
    end
    plot(node_counts, p_failures, "DisplayName", rf + " Hz");
    hold on;
end

title('Simulation of Multinode Communication');
xlabel('Node Count');
ylabel('Probability of Failure');
legend("show");
yline(10, "LineWidth", 3, "DisplayName", "10% Failure");

hold off;