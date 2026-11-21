function J_vol = amedfilt2_calc(img_vol) %#codegen
% 2-D Adaptive Median Filter
% This filter ignores edge effects and boundary conditions, as such, the
% output is a cropped version of the original image, where the amount
% cropped is equal to the maximum window size vertically and horizontally.
% Define smax as a constant

% define max_window_size
smax = 9;

% Calculate valid region limits for filter
[nrows, ncols,slices] = size(img_vol);

% Initialize Output Image (J_vol)
J_vol = zeros(nrows, ncols,slices);

ll = ceil(smax/2);
ul = floor(smax/2);

% Loop over the slices
for sl=1:slices
    I=img_vol(:,:,sl);
    J=img_vol(:,:,sl);
% Loop over the entire image ignoring edge effects
for rows = ll:nrows-ul
    for cols = ll:ncols-ul
        
        window_ind = -ul:ul;        
        region = I(rows+window_ind,cols+window_ind);
        centerpixel = region(ll,ll);
        for s = 3:2:smax
            
            % We can collapse the ROI calculations into a single function
            [rmin,rmax,rmed] = roi_stats(region,smax,s);
            % adapt region size
            if rmed > rmin && rmed < rmax
                if centerpixel <= rmin || centerpixel >= rmax
                    J(rows,cols) = rmed;
                end
                % stop adapting
                break;
            end
        end
    end
end

J_vol(:,:,sl) = J;
end


%To test the fuction
 temp_img_vol1 = double(img_vol(img_vol ~= 0));
%   figure, hist(temp_img_vol1);
  
  mean_sig1=nanmean(temp_img_vol1);
  sd_sig1=std(temp_img_vol1);
  
  
  temp_img_vol2 = double(J_vol(J_vol ~= 0));
%   figure, hist(temp_img_vol2);
  
  mean_sig2=nanmean(temp_img_vol2);
  sd_sig2=std(temp_img_vol2);
  
end


