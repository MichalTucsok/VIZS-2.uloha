function [im scale] = cfresize(im, longDimSize)
%CFRESIZE Zmena ve¾kosti obrázka, ak je jeho dymenzia vecsia 
%   [im scale] = cfresize(im,longDimSize); scales the image so its long 
%   dimension is logDimSize long. (iba ak je vecsia)   

s = size(im);
scale = min(longDimSize/max(s),1);
im = imresize(im, scale);