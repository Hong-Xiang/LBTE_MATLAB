function y = SphericalHarmonicBasis(mu, xi, eta, l, m)
    phi = atan2(xi, mu);
    if(m>0)
        y = 1/sqrt(pi)*NormalizedAssociatedLegendrePolynomails(l, m, eta).*cos(m*phi);
    end
    if(m==0)
        y = 1/sqrt(2*pi)*NormalizedAssociatedLegendrePolynomails(l, m, eta);
    end
    if(m<0)
        y = 1/sqrt(pi)*NormalizedAssociatedLegendrePolynomails(l, -m, eta).*sin(-m*phi);
    end

%     y = 1/sqrt(2*pi)*NormalizedAssociatedLegendrePolynomails(l, m, eta)*exp(sqrt(-1)*m*phi);
end