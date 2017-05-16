function image = kreslikruh(image, y, x, rad, col, width, pointnum, phase)
%kreslikruh  Draws a circle or ellipse on a RGB image.
%   image = kreslikruh(image, y, x, rad, [r g b], width)
%   Returns the image with a circle centerd at x ,y drawn.
%
%   image = kreslikruh(image, y, x, [radx rady], col, width) draws a ellipse
%   with is he width of the ellipse in pixels.

%   image = kreslikruh(image, y, x, rad, [r g b]) draws a circle colored by
%   r g b values.
%   image = kreslikruh(image, y, x, [radx rady]) draws a white ellipse.
%
%   If the ellipse is outside the image it will be drawn on the edge


if nargin < 5
    col = 255;
end

if nargin <6
    width = 1;
end
width = width - 1;

if nargin < 7
    delta = 1/max([rad,0.1]);
else
    delta = 2*pi/pointnum;
end;

if nargin < 8
    phaseX = 0;
    phaseY = 0;
else
    phaseX = phase(1);
    phaseY = phase(min(length(phase),2));
end

radx = rad(1);
rady = rad(min(length(rad),2));
r = col(1);
g = col(min(length(col),2));
b = col(min(length(col),3));

% vykreslenie 
deg = 0:delta:2*pi;
[sy sx isRGB] = size(image);

px = cos(deg + phaseY)*rady;
py = sin(deg + phaseX)*radx;
for wx =-width:width
    for wy = -width:width
        vy = min(max(round(y + wy + py),1),sy);
        vx = min(max(round(x + wx + px),1),sx);
        index = (vy-1) + (vx-1)*sy + 1;
        image(index) = r;
        if(isRGB == 3)
            image(index+sx*sy) = g;
            image(index+2*sx*sy) = b;
        end
    end
end
end