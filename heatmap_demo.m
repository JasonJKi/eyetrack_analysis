clear all; close all; dependencies install; 
scrn_width = 1280;
scrn_height  = 720;
condition_str = {'play', 'sham', 'watch'};

for i_condition = 1:3
    
    eyetrack = load(['data/eyetrack_stk_' condition_str{i_condition}],  'x', 'y', 'pupil_area');
    
    x = eyetrack.x; % x pos (unit pixels)
    y = eyetrack.y; % y pos (unit pixels)
    
    % 1. heatmap by brute force counting number of fixation over an area across time.
    eyetrack_heatmap = eyetracking_heatmap(x, y, scrn_width, scrn_height);
    %smoothed heatmap conversion to an rgb image
    eyetrack_heatmap_rgb = heatmap_to_rgb(eyetrack_heatmap, scrn_width, scrn_height, true); 
    
    % 2. 2d histogram using matlab function 
    fs = 20;
    ylin_space = (0:fs:scrn_height);
    xlin_space = (0:fs:scrn_width);
    eyetrack_matlab_hist = hist3([x, y], {xlin_space, ylin_space})';
    
    % corresponding src for 2d image.
    load(['data/src_heatmap_stk_' condition_str{i_condition}]);
    src_img = sum(src_img,3);
    src_img = imresize(src_img, [scrn_height, scrn_width]);
    
    if i_condition == 1
        caxis1 = [min(src_img(:)) max(src_img(:))];
        caxis2 = [min(eyetrack_heatmap(:)) max(eyetrack_heatmap(:))];
        caxis3 = [0 255];
        caxis4 = [min(eyetrack_matlab_hist(:)) max(eyetrack_matlab_hist(:))];
    end
    
    fig = figure('Units','normalized','Position',[0 0 .3 1]); clf
    subplot(4,1,1)
    imagesc(src_img)
    caxis(caxis1)
    colorbar('westoutside')
    axis image
    title('simulus responsible correlation')
    
    subplot(4,1,2)
    imagesc(imresize(eyetrack_heatmap, [scrn_height, scrn_width]));
    axis image
    caxis(caxis2)
    colorbar('westoutside'	)
    title('brute force count regional movement')
    
    subplot(4,1,3)
    imshow(eyetrack_heatmap_rgb);
    axis image
    caxis(caxis3)
    colorbar('westoutside'	)
    title('above smoothed and rgb converted')
    
    subplot(4,1,4)
    imagesc(imresize(eyetrack_matlab_hist, [scrn_height, scrn_width]));
    axis image
    caxis(caxis4)
    colorbar('westoutside'	)
    title('matlab 2d hist')
    
    suptitle(condition_str{i_condition})

    saveas(fig, ['output/demo_figure_' condition_str{i_condition}],'png')

end
