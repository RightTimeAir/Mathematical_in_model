# DBSCAN算法
DBSCAN方法是一种基于密度的聚类方法
以下用MATLAB实现DBSCAN算法
main函数
```matlab
clc;
clear;
close all;

load mydata;%导入数据

%% Run DBSCAN Clustering Algorithm

epsilon=0.5;%表示半径
MinPts=10;%表示最少点个数
IDX=DBSCAN(X,epsilon,MinPts);


%% Plot Results
% 如果只要两个指标的话就可以画图啦
%得出的IDX是聚类的结果，若是0，则是孤立点
% PlotClusterinResult(X, IDX);  
%这是画图的代码
% title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
```
DBSCAN部分
```matlab

function [IDX, isnoise]=DBSCAN(X,epsilon,MinPts)

    C=0;
    
    n=size(X,1);
    IDX=zeros(n,1);  % 初始化全部为0，即全部为噪音点
    
    D=pdist2(X,X);
    
    visited=false(n,1);
    isnoise=false(n,1);
    
    for i=1:n
        if ~visited(i)
            visited(i)=true;
            
            Neighbors=RegionQuery(i);
            if numel(Neighbors)<MinPts
                % X(i,:) is NOISE
                isnoise(i)=true;
            else
                C=C+1;
                ExpandCluster(i,Neighbors,C);
            end
            
        end
    
    end
    
    function ExpandCluster(i,Neighbors,C)
        IDX(i)=C;
        
        k = 1;
        while true
            j = Neighbors(k);
            
            if ~visited(j)
                visited(j)=true;
                Neighbors2=RegionQuery(j);
                if numel(Neighbors2)>=MinPts
                    Neighbors=[Neighbors Neighbors2];   %#ok
                end
            end
            if IDX(j)==0
                IDX(j)=C;
            end
            
            k = k + 1;
            if k > numel(Neighbors)
                break;
            end
        end
    end
    
    function Neighbors=RegionQuery(i)
        Neighbors=find(D(i,:)<=epsilon);
    end

end

```
画图的PlotClusterinResult代码
```matlab
function PlotClusterinResult(X, IDX)

    k=max(IDX);

    Colors=hsv(k);

    Legends = {};
    for i=0:k
        Xi=X(IDX==i,:);
        if i~=0
            Style = 'x';
            MarkerSize = 8;
            Color = Colors(i,:);
            Legends{end+1} = ['Cluster #' num2str(i)];
        else
            Style = 'o';
            MarkerSize = 6;
            Color = [0 0 0];
            if ~isempty(Xi)
                Legends{end+1} = 'Noise';
            end
        end
        if ~isempty(Xi)
            plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
        end
        hold on;
    end
    hold off;
    axis equal;
    grid on;
    legend(Legends);
    legend('Location', 'NorthEastOutside');

end
```
# DBSCAN的优缺点
优点：
1. 基于密度定义，能处理任意形状和大小的簇；
2. 可在聚类的同时发现异常点；
3. 与K-means比较起来，不需要输入要划分的聚类个数。
缺点：
1. 对输入参数 $\varepsilon$ 和Minpts敏感，确定参数困难；
2. 由于DBSCAN算法中，变量 $\varepsilon$ 和Minpts是全局唯一的，当聚类的密度不均匀时，聚类距离相差很大时，聚类质量差；
3. 当数据量大时，计算密度单元的计算复杂度大。


# 伪代码的概念
伪代码是一种非正式的类似于英语结构的用于描述模块结构图的语言。使用伪代码的目的是使被描述的算法可以容易地以任何一种变成语言实现；