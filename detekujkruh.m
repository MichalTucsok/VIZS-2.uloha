clc
close all
clear all

filename = 'lopta.jpg';
im = imread(filename);
% imread nacita obrazok zo suboru

% funkcia najdi kruh
[r c rad] = najdikruh(im);

% vykresli kruh
% image = kreslikruh(im, y, x, rad, [r g b])
for n=1:length(rad)
    im = kreslikruh(im,r(n),c(n),rad(n),[0 0 255],3);
end
figure;
imshow(im)