%model developeed to take into account the strain developed by deleting
%genes associated with PTS deletion, removing flux through diffusion
%transfer and deleting/controlling flux through glucose dehydrogenase 
%reaction in the periplasm
model=readCbModel('KTS022'); %import model
changeCobraSolver('glpk'); %only glpk and matlab solvers available
changeCbMapOutput('svg');
upper=num2cell(model.ub);
lower=num2cell(model.lb);
reactions=[model.rxns,lower,upper];
model = changeRxnBounds(model,'EX_glc__D(e)',-5.737,'l');
model = changeObjective(model,'BIOMASS_Ecoli_core_w_GAM');
FBAsolution = optimizeCbModel(model,'max');
fprintf('wild type growth rate: %f hr-1 \n',FBAsolution.f);

model = changeRxnBounds(model,'GLCt2',5.7,'u'); %1342 GalP
model = changeRxnBounds(model,'HEX1',3.8,'u'); %1486 Glucokinase
FBAsolution = optimizeCbModel(model,'max');
fprintf('PTS minus growth rate: %f hr-1 \n',FBAsolution.f);
optimflux=[model.rxns,num2cell(FBAsolution.x)];


% mu=zeros(10,1);
% G6Pflux=zeros(10,1);
% for i=1:10
%     model = changeRxnBounds(model,'HEX1',3/i,'u');
%     G6Pflux(i)=3/i;
%     FBAsolution = optimizeCbModel(model,'max');
%     mu(i)=FBAsolution.f;
% end
% plot(mu,G6Pflux);

%regulatory model
% [FBAsols,DRgenes,constrainedRxns,cycleStart,states] = optimizeRegModel(model);

%map
% map=readCbMap('e_coli_core');
% options.lb = -10;
% options.ub = 10;
% options.zeroFluxWidth = 0.1;
% options.rxnDirMultiplier = 10;
% options.textsize = 12;

% Draw the flux values on the map "target.svg" which can be opened in web
% browser

% drawFlux(map, model, FBAsolution.x, options);

