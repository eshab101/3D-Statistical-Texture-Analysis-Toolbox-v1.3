function [avg_iron] = mean_iron(img,mask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 avg_iron = 0;
%  size(img)
%  size(mask)
 roi_iron = zeros(size(mask));
 roi = zeros(size(mask,1), size(mask,2));
 
for i= 1: size(mask,3)
       roi(:,:) = double(mask(:,:,i));
       roi_iron(:,:,i) = immultiply(double(img(:,:,i)),roi);
end

 roi_iron1 = roi_iron(roi_iron~=0);
 avg_iron = mean(roi_iron1);
end