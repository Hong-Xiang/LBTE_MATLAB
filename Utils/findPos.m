function id = findPos(x0, x)
    id = ones(size(x));
    nx = numel(x);
    nx0 = numel(x0);
    xmin = x0(1);
    xmax = x0(end);
    dx = (xmax-xmin)/nx0;
    for i = 1 : nx
        id = ceil((x-xmin)/dx);
        id = min(id, nx0-1);
        id = max(id, 1);        
    end
end

