function model = KTS_builder(o2flux)
model=readCbModel('KTS022'); %import model
% changeCobraSolver('glpk'); %only glpk and matlab solvers available
model = changeRxnBounds(model,'EX_glc__D(e)',-5.737,'l');
model = changeRxnBounds(model,'EX_o2(e)',o2flux,'l'); %optimized value = -4.6885
model = changeObjective(model,'BIOMASS_Ecoli_core_w_GAM');
model = changeRxnBounds(model,'GLCt2',5.7,'u'); %1342 GalP
model = changeRxnBounds(model,'HEX1',3.8,'u'); %1486 Glucokinase
model = changeRxnBounds(model,'GDH',0,'u');
model = changeRxnBounds(model,'GDH',0,'l');
model=mywork_addProteinGroupsToModel(model);
model.protGroup(1).phi0 = 0;
model.protGroup(2).phi0 = 0;
model.protGroup(3).phi0 = 0.066;
model.protGroup(4).phi0 = 0.5; %0.5
model=setWeights(model,1,0.003);
model=setWeights(model,2,0.0018); %0.0018
model=setWeights(model,3,0.169);
model=setWeights(model,4,0);