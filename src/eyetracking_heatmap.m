function [heatmap]=eyetracking_heatmap(x_pos, y_pos, scrn_width, scrn_height)

fs = scrn_width/16;
y_pos_hm = (0:fs:scrn_height);
x_pos_hm = (0:fs:scrn_width);
hm_height = length(y_pos_hm) -1 ; %number of vertical elements in heatmap matrix
hm_width = length(x_pos_hm) - 1;

heatmap = zeros(hm_height, hm_width);
%initialize counters
for i = 1:hm_height
    for j = 1:hm_width
        % this algorithm counts the number of eye fixation over a region
        % over time.
        heatmap(i, j) = count_fixation_in_region(x_pos, y_pos, x_pos_hm(j), y_pos_hm(i), x_pos_hm(j+1), y_pos_hm(i+1));
    end
end

end

function n_records_region = count_fixation_in_region(x, y, left_up_edge_x, left_up_edge_y, right_down_edge_x, right_down_edge_y)

%edges of region
right_up_edge_x = right_down_edge_x;
right_up_edge_y = left_up_edge_y;
left_down_edge_x= left_up_edge_x;
left_down_edge_y = right_down_edge_y;

%total number of records
n=size(x);
n=n(1,1);

%number of records in region 
n_records_region=0;
for i=1:n
    if (x(i)>left_up_edge_x || x(i)==left_up_edge_x) &&( x(i)<right_up_edge_x || x(i)==right_up_edge_x )&& (y(i)>left_up_edge_y || y(i)==left_up_edge_y) &&( y(i)<left_down_edge_y || y(i)==left_down_edge_y)
        n_records_region=n_records_region+1;
    end
end

end
