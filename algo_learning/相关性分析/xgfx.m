clc;clear;
load('happydata.mat')
%相关性分析
%默认类型为Pearson系数
[xiangguan,p_value]=corr(data);%等效于xiangguan=corr(data,'Type','Pearson');
%x轴和y轴的标签，要和数据的列数对应
index_name={'Score','Economy','Family','Health','Freedom','Generosity','Trust','Residual'};
y_index = index_name;
x_index=index_name;
figure(1)
%字号12，字体宋体，可以随意改变 显示默认配色
H = heatmap(x_index,y_index, p_value, 'FontSize',12, 'FontName','宋体');
H.Title = '皮尔逊相关性分析系数检验矩阵'; 
%%
figure(2)
% 可以自己定义颜色块
H = heatmap(x_index,y_index, xiangguan, 'FontSize',12, 'FontName','宋体');
H.Title = '皮尔逊相关性分析系数矩阵'; 
yandata=xlsread('颜色图.xlsx');
yandata1=yandata(1:6,:);% 取1—6行颜色
color=yandata1/255;
colormap(color)
%%
%	Kendall tau 系数
figure(3)
[xiangguan,~]=corr(data,'Type','Kendall');
H = heatmap(x_index,y_index, xiangguan, 'FontSize',12, 'FontName','宋体');
H.Title = 'Kendall tau 相关系数矩阵'; 
% 自己定义颜色块
yandata=xlsread('颜色图.xlsx');
yandata1=yandata(7:12,:);% 取7—12行颜色
color=yandata1/255;
colormap(color)
%%
%	Spearman系数
figure(4)
[xiangguan,~]=corr(data,'Type','Spearman');
H = heatmap(x_index,y_index, xiangguan, 'FontSize',12, 'FontName','宋体');
H.Title = 'Spearman相关系数矩阵'; 
% 自己定义颜色块
yandata=xlsread('颜色图.xlsx');
yandata1=yandata([8,9,5,23,21],:);% 取指定行颜色
color=yandata1/255;
colormap(color)