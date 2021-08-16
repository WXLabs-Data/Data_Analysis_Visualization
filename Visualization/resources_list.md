# 参考资源列表
在这里可以把可视化资源网站贴在这里

## 图表分类
[data-to-viz](https://www.data-to-viz.com/)

## Python实现
1. [datasciencescoop/Data-Visualization](https://github.com/datasciencescoop/Data-Visualization)
  Matplotlib包：line chart, Bar chart, Scatter chart, Histogram, Pie charts, Area chart, Dount chart；
  Seaborn包：各种图；

## R实现
1. [R graph gallery](https://www.r-graph-gallery.com/index.html)
2. [R charts](https://r-charts.com)

|                  |                                                   | dependency                           | 实现难度 | 实现难点       | 注意事项 |
| ---------------- | ------------------------------------------------- | ------------------------------------ | -------- | -------------- | -------- |
| part of a whole  | pie                                               | ggforce::geom_arc_bar                | ***      | - 标签位置坐标 |          |
|                  | [variation] pie - doughnut                        |                                      | ***      |                |          |
|                  | [variation] pie - multi-level                     |                                      | ****     |                |          |
|                  | treemap                                           | treemapify::geom_treemap             | *        |                |          |
|                  | venn                                              | geom_point VennDiagram::venn.diagram | **       |                |          |
|                  | stacked barplot                                   | geom_bar(position=position_stack())  | *        |                |          |
| 比较/排名        | grouped barplot                                   | geom_bar(position=position_dodge())  | *        |                |          |
|                  | bubble                                            | geom_point(aes(size=...))            | *        |                |          |
|                  | radar                                             | ggradar::geom_radar                  | ***      |                |          |
|                  | cicular barplot                                   |                                      | ***      |                |          |
|                  | [variation] barplot - for likert item             | likert::likert                       | *        |                |          |
|                  | [variation] barplot - radial bar                  |                                      | ***      |                |          |
|                  | [variation] barplot - radial line                 |                                      | ***      |                |          |
| 分布             | boxplot                                           | geom_boxplot                         | *        |                |          |
|                  | [variation] scatter - beeswarm                    | ggbeeswarm::geom_beeswarm()          | *        |                |          |
|                  | density                                           | geom_density                         | *        |                |          |
|                  | [variation] density - violin                      | geom_violin                          | *        |                |          |
|                  | [with comparison] [variation] density - ridgeline | ggridges::geom_density_ridges        | *        |                |          |
|                  | scatter                                           | geom_point                           | *        |                |          |
|                  | histogram                                         | geom_histogram                       | *        |                |          |
| 相关             | correlation matrix                                | rstatix::cor_plot                    | *        |                |          |
|                  | density 2d                                        | geom_density2d                       | **       |                |          |
|                  | scatter                                           | geom_point                           | *        |                |          |
|                  | arc                                               | ggforce::geom_arc                    | **       |                |          |
| 流动             | sankey                                            |                                      | ***      |                |          |
|                  | arc                                               | ggforce::geom_arc                    | **       |                |          |
| 变化（随时间的） |                                                   | geom_line                            | *        |                |          |
|                  | step line                                         | geom_step                            | *        |                |          |
