function Res = Main()
 p = Parameters(); 
 Test2Run = {'LBTE','Ana'};
 nRun = numel(Test2Run);
 Res = struct;
 Res.p = p;
 Res.dose = cell(nRun,1);
 Res.method = cell(nRun,1); 
 for i = 1 : nRun
     Res.method{i} = Test2Run{i};
     if strcmp(Res.method{i},'LBTE')
         Res.dose{i} = SolverSH(p);
     end
     if strcmp(Res.method{i},'Ana')
         Res.dose{i} = SolverAna(p);
     end
     if strcmp(Res.method{i},'MC')
         Res.dose{i} = SolverMC(p);
     end
 end
 ShowResult(Res);
%  save(['Result/',p.outputFileName],'Res');
end

