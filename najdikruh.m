%najdikruh finds circles in an RGB or grayscale image.
%   EXTRACTCIRCLES(houghTrans, tresh , radVec, maxVec)
%   returning a list of circles (row, column, radius) in image im. 
%
% Arguments: 
%           im - RGB or grayscale image.
%           radMin - (optional)the minimum radius of a candidate circle.
%           radMax - (optional)the maximum radius of a candidate circle.
%           tresh - (optional)threshold in the range (0,1].
%           imresize - (optional)the size in pixels of the internal resizing
%                     if its bigger then the longest dimension of the image
%                     the internal image will not be re sized.
%           imDisp - (optional)if passed the circles found will be
%           displayed on this image.
% 
% Return values:
%            r - vektor suradnic kruhu
%            c - vektor stlpcov kruhu
%            rad - vektor polomeru kruhu
%            maxVec - a vector with the same length as radVec 
%                    indicating the likelihood of a circle in the
%                    corresponding radius. 
%            houghTrans - a 3 dimensional matrix holding the hough transform 
%
% Useage example:
%         [r , c , rad] = najdikruh(im);
%         finds  circles with the default settings.
%         
%        [r , c , rad] = najdikruh(im, [], [], 0.4);
%        finds  circles with the default radius min and max values
%        and a threshold set 0.4





function [r , c , rad, maxVec, houghTrans] = najdikruh(im, radMin, radMax, thresh, imresize, imDisp)

if(nargin<5 || isempty(imresize))
    imresize = 150;
end


[im scale]= cfresize(im, imresize);
s = size(im);

if(nargin<2 || isempty(radMin))
    radMin = 10;
else
    radMin = round(radMin*scale);
end
radMin = max(radMin,4);

if(nargin<3 || isempty(radMax))
    radMax = floor(max(s)/2);
else
    radMax = round(radMax*scale);
end

if(length(s) == 3 )
    im = edge(im(:,:,1))|edge(im(:,:,2))|edge(im(:,:,3))|edge(rgb2gray(im),'prewitt');
else
    im = edge(im(:,:,1));
end

radVec = radMin:1:radMax;
[houghTrans maxVec] = houghtransform(im, radVec);

if(nargin < 4  || isempty(thresh))
    thresh = min(max(maxVec)*0.7,0.21);
end

% extrahuje kruhovu poziciu z transformovaneho obrazka
% 
[r c rad] = extractcircles(houghTrans, thresh, radVec, maxVec);

% vahy
r = r/scale; 
c = c/scale;
rad = rad/scale;

radVec = radVec./scale;

% zobrazenie obrazka z oznacenim kruhom 
% if(nargin==6)
%     
% %     figure(3);
% %     plot(radVec,maxVec);
% %     title('pravdepodobnost kruhu pre dany polomer');
% %     xlabel('polomer');
%     
%     for n=1:length(rad)
%         imDisp = kreslikruh(imDisp,r(n),c(n),rad(n), [0 255 0], 2);
%     end
%     figure;
%     imshow(imDisp);
%     
% end