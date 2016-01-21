function [bx0, bx1, by0, by1, bz0, bz1] = GetBoundary(p, el, eh)
if  p.testAnaCase == 0
    bx0 = zeros(size(p.bxy));
    bx1 = zeros(size(p.bxy));
    by0 = zeros(size(p.byx));
    by1 = zeros(size(p.byx));
    bz0 = zeros(size(p.bzx));
    bz1 = zeros(size(p.bzx));
else
%Get boundary flux of all six surfaces of energy group (el, eh]
    bx0 = GetGroupTerm(p, @AnalyticalSolution, -p.hx*ones(size(p.bxy)), p.bxy, p.bxz, p.bxmu, p.bxxi, p.bxeta, el, eh);
    bx1 = GetGroupTerm(p, @AnalyticalSolution,  p.hx*ones(size(p.bxy)), p.bxy, p.bxz, p.bxmu, p.bxxi, p.bxeta, el, eh);
    by0 = GetGroupTerm(p, @AnalyticalSolution, p.byx, -p.hy*ones(size(p.byz)), p.byz, p.bymu, p.byxi, p.byeta, el, eh);
    by1 = GetGroupTerm(p, @AnalyticalSolution, p.byx,  p.hy*ones(size(p.byz)), p.byz, p.bymu, p.byxi, p.byeta, el, eh);
    bz0 = GetGroupTerm(p, @AnalyticalSolution, p.bzx, p.bzy, -p.hz*ones(size(p.bzy)), p.bzmu, p.bzxi, p.bzeta, el, eh);    
    bz1 = GetGroupTerm(p, @AnalyticalSolution, p.bzx, p.bzy,  p.hz*ones(size(p.bzy)), p.bzmu, p.bzxi, p.bzeta, el, eh);    
end
end