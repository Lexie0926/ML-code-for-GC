
clear
clc

%%
% 1. load data
load test.mat
 
%%
% 2. generation of dataset randomly
temp = randperm(size(testx,1));

P_train = testx(temp(1:50),:)';
T_train = testy(temp(1:50),:)';

P_test = testx(temp(1:end),:)';
T_test = testy(temp(1:end),:)';
N = size(P_test,2);
 

%%
% 1. conduct the network
net = newrbe(P_train,T_train,30); 
 
%%
% 2. simulation test
T_sim = sim(net,P_test);
 

%%
% 1. error
error = abs(T_sim - T_test)./T_test;
 
%%
% 2. R^2
R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
 
%%
% 3. result comparison
result = [T_test' T_sim' error']

figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('real value','predicted value')
xlabel('experiments')
ylabel('y')
string = {'comparison';['R^2=' num2str(R2)]};
title(string)