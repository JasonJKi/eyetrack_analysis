function heatmap_rgb = heatmap_to_rgb(heatmap, scrn_width, scrn_height, smoothing)

if nargin < 3 
    smoothing = false;
end

% convert to 0-255 scale.
heatmap=(255/max(max(heatmap)))*heatmap;
heatmap=floor(heatmap);%integer values
heatmap=uint8(heatmap);

%resize heatmap to adjust to img resolution
heatmap=imresize(heatmap,[scrn_height scrn_width],'bicubic');

% heatmap_rgb = ind2rgb(heatmap,colormap('jet'));
% 
% kernel_size_gaussian = 5;
% s_gaussian = 3;
% h = fspecial('gaussian',kernel_size_gaussian,s_gaussian);
% heatmap_rgb = imfilter(heatmap_rgb,h,'replicate');
% 
% return
%create RGB heatmap
heatmap_rgb=zeros(scrn_height,scrn_width,3);
%initialize R,G,B
R=zeros(scrn_height,scrn_width);
G=zeros(scrn_height,scrn_width);
B=zeros(scrn_height,scrn_width);

% c_scale_upper = [25:25:225];
% c_scale_lower = c_scale_upper-25;
% rgb_scale = [10 10 10; 60 60 60; 0 0 255; 0 255 210; 0 255 75; 192 255 0;255 240 0; 255 192 0; 255 150 0; 255 0 0];

for i=1:scrn_height
    for j=1:scrn_width
        
        if (heatmap(i,j)==0 || heatmap(i,j)>0) && (heatmap(i,j)==25 || heatmap(i,j)<25)
            R(i,j)=10;
            G(i,j)=10;
            B(i,j)=10;
            
        elseif (heatmap(i,j)==26 || heatmap(i,j)>26) && (heatmap(i,j)==50 || heatmap(i,j)<50)
            R(i,j)=60;
            G(i,j)=60;
            B(i,j)=60;
            
        elseif (heatmap(i,j)==51 || heatmap(i,j)>51) && (heatmap(i,j)==75 || heatmap(i,j)<75)
            R(i,j)=0;
            G(i,j)=0;
            B(i,j)=255;
            
        elseif (heatmap(i,j)==76 || heatmap(i,j)>76) && (heatmap(i,j)==100 || heatmap(i,j)<100)
            R(i,j)=0;
            G(i,j)=255;
            B(i,j)=210;
            
        elseif (heatmap(i,j)==101 || heatmap(i,j)>101) && (heatmap(i,j)==125 || heatmap(i,j)<125)
            R(i,j)=0;
            G(i,j)=255;
            B(i,j)=75;
            
        elseif (heatmap(i,j)==126 || heatmap(i,j)>126) && (heatmap(i,j)==150 || heatmap(i,j)<150)
            R(i,j)=192;
            G(i,j)=255;
            B(i,j)=0;
            
        elseif (heatmap(i,j)==151 || heatmap(i,j)>151) && (heatmap(i,j)==175 || heatmap(i,j)<175)
            R(i,j)=255;
            G(i,j)=240;
            B(i,j)=0;
            
        elseif (heatmap(i,j)==176 || heatmap(i,j)>176) && (heatmap(i,j)==200 || heatmap(i,j)<200)
            R(i,j)=255;
            G(i,j)=192;
            B(i,j)=0;
            
        elseif (heatmap(i,j)==201 || heatmap(i,j)>201) && (heatmap(i,j)==225 || heatmap(i,j)<225)
            R(i,j)=255;
            G(i,j)=150;
            B(i,j)=0;
            
        else
            R(i,j)=255;
            G(i,j)=0;
            B(i,j)=0;
        end
    end
end
R=uint8(R);
G=uint8(G);
B=uint8(B);
heatmap_rgb(:,:,1)=R;
heatmap_rgb(:,:,2)=G;
heatmap_rgb(:,:,3)=B;
heatmap_rgb=uint8(heatmap_rgb);

if smoothing 
    kernel_size_gaussian = 5;
    s_gaussian = 3;
    h = fspecial('gaussian',kernel_size_gaussian,s_gaussian);
    heatmap_rgb = imfilter(heatmap_rgb,h,'replicate');
end
end
