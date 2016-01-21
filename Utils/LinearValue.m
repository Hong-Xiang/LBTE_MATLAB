function v = LinearValue(x0, y0, x1, y1, x)
    v = ((x-x0).*y0 + (x1 - x).*y1)./(x1-x0);   
end

