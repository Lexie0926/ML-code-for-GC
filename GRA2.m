clc;clear;
%读取数据
data=xlsread('E:\001实验室\文章 专利\22.5- 提取工艺 中文改外文\数据\twater.xlsx');
%数据标准化
data1=mapminmax(data',0.0,1); %标准化到0.00-1区间
data1=data1';

%%计算灰色相关系数
%得到其他列和参考列相等的绝对值
for i=2:8
    data1(:,i)=abs(data1(:,i)-data1(:,1));
end
 
%得到绝对值矩阵的全局最大值和最小值
data2=data1(:,2:8);
d_max=max(max(data2));
d_min=min(min(data2));
%灰色关联矩阵
a=0.5;   %分辨系数
data3=(d_min+a*d_max)./(data2+a*d_max);
xishu=mean(data3);
disp(' x4,x5,x6,x7,x8,x9,x10 与 x1之间的灰色关联度分别为：')
disp(xishu)