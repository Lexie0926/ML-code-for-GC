clear
clc
load RBFetohy1
net1=net;
load RBFetohy2
net2=net;
fitnessfcn = @my_first_multi;  
nvars = 4;                      
lb = [8 1 1 40];                   
ub = [14 3 3 60];                     
A = []; b = [];                 
Aeq = []; beq = [];            
options = gaoptimset('ParetoFraction',0.3,'PopulationSize',100,'Generations',500,'StallGenLimit',200,'TolFun',1e-100,'PlotFcns',@gaplotpareto);

[x,fval] = gamultiobj(fitnessfcn,nvars, A,b,Aeq,beq,lb,ub,options);


