
clear all
clc

%%
% 1. load data
load test.mat
 
%%

temp = randperm(size(testx,1));

P_train = testx(temp(1:50),:)';
T_train = testy(temp(1:50),:)';

P_test = testx(temp(1:end),:)';
T_test = testy(temp(1:end),:)';
N = size(P_test,2);
 

[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);
[t_train, ps_output] = mapminmax(T_train,0,1);

%%
% 1. conduct network
net = newff(p_train,t_train,5);
 
%%
% 2. 设置训练参数
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.01;
 
%%

net = train(net,p_train,t_train);
 
%%

t_sim = sim(net,p_test);
 
%%

T_sim = mapminmax('reverse',t_sim,ps_output);
 

%%

error = abs(T_sim - T_test)./T_test;
 
%%
% R^2
R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
 
%%

result = [T_test' T_sim' error']

figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('real value','predicted value')
xlabel('experiment')
ylabel('y')
string = {'comparison';['R^2=' num2str(R2)]};
title(string)
