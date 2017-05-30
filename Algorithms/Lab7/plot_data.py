# -*- coding: utf-8 -*-

import collections
from pylab import figure, show
from math import log

def plot_data(data, logarithmic=False, oneplot=False, data_2={}, 
              label_data2_label=True,
              data_label='', data2_label='',
              legend_pos=0, legend2_pos=0, 
              show_markers=True):
#    print data
    fig = figure(1)
    num = 0
    if oneplot==True:
        num = 1
        if len(data_2)>0:
            num += 1
    else:
        num = len(data)
        if len(data_2)>0:
            num += 1
    colors = ['r','b','g','c','m','y']
    markers = ['s','o','x','^','v','<','>']
    
    ax = fig.add_subplot(num, 1, 1)
    ax.grid(True)
    if data_label:
        ax.set_title(data_label)
    i = -1
    line_titles = []
    x_max = y_max = 0
    labels_num = len(data)
    for label, points in data.iteritems():
        i += 1
        od_points = collections.OrderedDict(sorted(points.items()))
        if logarithmic:
            xs = [(x>0 and log(x,10) or 0) for x in od_points.keys()]
            ys = [(y>0 and log(y,10) or 0) for y in od_points.values()]
        else:
            xs = od_points.keys()
            ys = od_points.values()
        xs.insert(0,0)
        x_max = max(x_max, max(xs))
        ys.insert(0,0)
        y_max = max(y_max, max(ys))
        line = colors[i%labels_num]+'-'
        if show_markers:
            line += markers[i%labels_num]
        ax.plot(xs, ys, line, label=label )
        line_titles.append(label)
    ax.set_xlim( (0, x_max*1.1) )
    ax.set_ylim( (0, y_max*1.1) )
    ax.legend(line_titles, loc=legend_pos)

            
    if len(data_2)>0:
        ax = fig.add_subplot(num,1,num)
        ax.grid(True)
        if data2_label:
            ax.set_title(data2_label)
        i = -1
        line_titles = []
        x_max = y_max = 0
        for label, value in data_2.iteritems():
            i += 1
            j = -1
            sort_num = len(value)
            for name, points in value.iteritems():
                j += 1
                od_points = collections.OrderedDict(sorted(points.items()))
                if logarithmic:
                    xs = [(x>0 and log(x,10) or 0) for x in od_points.keys()]
                    ys = [(y>0 and log(y,10) or 0) for y in od_points.values()]
                else:
                    xs = od_points.keys()
                    ys = od_points.values()
                xs.insert(0,0)
                x_max = max(x_max, max(xs))
                ys.insert(0,0)
                y_max = max(y_max, max(ys))
                line = colors[j%sort_num]+lines[i%num]
                if show_markers:
                    line += markers[j%sort_num]
                ax.plot(xs, ys, line )
                if label_data2_label:
                    line_titles.append(name+' '+label)
                else:
                    line_titles.append(name)
        ax.set_xlim( (0, x_max*1.1) )
        ax.set_ylim( (0, y_max*1.1) )
        ax.legend(line_titles, loc=legend2_pos)
    show()