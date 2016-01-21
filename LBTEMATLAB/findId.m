function id = findId(value, data)
    id = 1;
    err = norm(data(:,1)-value);
    for i = 2 : size(data,2)
         te = norm(data(:,i)-value);
         if te < err
             err = te;
             id = i;
         end
    end
end

