function [houghTrans maxVec] = houghtransform(im, radVec) 
%   HOUGHTRANSFORM(im, radVec) transformacia pre najdenie kruhov s polomermi oznacenymi ako (radVEC)
%   na binarnom obrazku v matici im.
% 
%   funkcia :
%       houghTrans - trojrozmernu houghovu maticu   
%       maxVec - vektor s rovnakou dlzkou ako radVEC oznacujuci pododbnost
%                kruznice v prislusnom polomere-



eps = 0.3; %pre mensie kruhy si zvolime
s = size(im);
houghTrans = zeros(s(1),s(2), length(radVec));
maticaim = zeros(s(1)+2,s(2)+2);
hs = size(maticaim);
for n = 1:length(radVec)
    rad = radVec(n);       
    delta = 2/rad;
    deg = 0:delta:2*pi;
    
%     vyuzitie parametrickej kruznice s vyuzitim uhla, polomeru a suradnice
%     stredu 

    pX = cos(deg)*rad;
    pY = sin(deg)*rad;
    color = 1/(2*pi*rad+eps); %(pre velke kruhy color=1);
%     color = 1; %(pre velke kruhy color=1);
    for i=1:s(1)
        for j=1:s(2)            
            if(im(i,j)>0)
                maticaim = maticaim*0;
                vi = min(max(round(i + pX + 1),1),hs(1));
                vj = min(max(round(j + pY + 1),1),hs(2));
                index = (vi-1) + (vj-1)*hs(1) + 1;
                maticaim(index) = color;                
                houghTrans(:,:,n) = houghTrans(:,:,n) +maticaim(2:(end-1), 2:(end-1));
            end
            
        end
    end
end

maxVec = squeeze(max(max(houghTrans)));