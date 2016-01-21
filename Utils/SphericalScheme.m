function [nlm, Ylm] = SphericalScheme(maxL, ang)
    nlm = (maxL+1)^2;
    na = size(ang,2);
    Ylm = zeros(nlm,na);
    for l = 0 : maxL
        for m = -l : l
           clm = ilm(l,m);
           Ylm(clm,:) = SphericalHarmonicsFunctionReal(l,m,ang);
        end
    end
%     Ylm = Ylm / sqrt(2);
end

