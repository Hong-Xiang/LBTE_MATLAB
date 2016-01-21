function v = HG_de(p, e0)
v = zeros(size(e0));
for i = 1 : numel(e0)
    e = e0(i);
    v(i) = HG_sigmaa(p,e).*(e-p.cute) + integral(@(x) HG_dsigmasde(p,e, x).*(e-x), p.cute, e);
end
end

