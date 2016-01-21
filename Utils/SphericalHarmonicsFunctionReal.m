function y = SphericalHarmonicsFunctionReal(l, m, ang)
cost = ang(3,:);
phi = atan2(ang(2,:),ang(1,:));    
sq2 = sqrt(2);
ma = abs(m);
if m > 0
    y = cos(ma*phi);
end
if m == 0
    y = 1/sq2;
end
if m < 0
    y = sin(ma*phi);
end
    y = y * sq2 * sqrt((2*l+1)/4/pi * factorial(l-ma)/factorial(l+ma)) .* LegendrePoly(l, ma, cost);
end

