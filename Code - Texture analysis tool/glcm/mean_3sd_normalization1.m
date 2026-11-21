function [ norm_img_vol ] = mean_3sd_normalization1( img_vol, mask_vol )
%
%   This function performs normalization of intensity values in image sequence 
%   with mean +- 3*SD of intensity value in the ROI

%     To test this function load data

%     img = load_untouch_niigz('20160610_110528DWI11bCLEARs1101a1011.nii.gz');
%     mask = load_untouch_niigz('tumor baseline.nii.gz');
%     img_vol = img.img(:,:,:,11);
%     mask_vol = mask.img;
    

   total_slice = size(img_vol,3);
   for k= 1:total_slice
      tumormask = double(mask_vol(:,:,k));
       
       norm_img_vol(:,:,k) = immultiply(double(img_vol(:,:,k)),tumormask);
   end
   
   %   Collect nonzero values
   
  temp_img_vol1 = norm_img_vol(norm_img_vol ~= 0);
%   figure, hist(temp_img_vol1);
  
  mean_sig1=nanmean(temp_img_vol1);
  sd_sig1=std(temp_img_vol1);
  sig_max1 = mean_sig1+3*sd_sig1;
  sig_min1 =mean_sig1-3*sd_sig1;
%   sig_skew1 = skewness(temp_img_vol1);
%   sig_kurt1 = kurtosis(temp_img_vol1);
%   sig_mode1 = mode(temp_img_vol1);
%   sig_entropy1 = entropy(temp_img_vol1);
  
  norm_img_vol(norm_img_vol<sig_min1) = 0;
  norm_img_vol(norm_img_vol>sig_max1) = 0;
  
% For checking the changes in mean and SD after normalization
  
%   temp_img_vol2 = norm_img_vol(norm_img_vol ~= 0);
%   figure, hist(temp_img_vol2);

%   mean_sig2=nanmean(temp_img_vol2);
%   sd_sig2=nanstd(temp_img_vol2);
%   sig_max2 = mean_sig2+3*sd_sig2;
%   sig_min2 =mean_sig2-3*sd_sig2;
%   sig_skew2 = skewness(temp_img_vol2);
%   sig_kurt2 = kurtosis(temp_img_vol2);
%   sig_mode2 = mode(temp_img_vol2);
%   sig_entropy2 = entropy(temp_img_vol2);
end

