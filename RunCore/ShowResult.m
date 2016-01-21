function ShowResult(res)
nplot = size(res.method,1);
legends = cell(1,nplot);
phi = cell(1,nplot);
phi1 = cell(1,nplot);
for i = 1 : nplot        
    phi{i} = res.dose{i};
    phi1{i} = n3D21D(phi{i});    
    legends{i} = res.method{i};
end

nx = numel(phi1{1});
x = 1 : nx;
plotcell = cell(nplot*2,1);
for iplot = 1 : nplot
    plotcell{2*iplot-1} = x;
    plotcell{2*iplot} = phi1{iplot};
end
plot(plotcell{:});
legend(legends);
end