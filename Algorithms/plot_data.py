# -*- coding: utf-8 -*-

import collections
from pylab import figure, show
from math import log

def plot_data(data, logarithmic=False, oneplot=False, data_2={}):
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
    colors = ['r','b','g']
    markers = ['s','o','x']
    lines = ['-','--',':']
    if oneplot==True:
        ax = fig.add_subplot(num, 1, 1)
        ax.grid(True)
        i = -1
        line_titles = []
        x_max = y_max = 0
        for label, value in data.iteritems():
            i += 1
            j = -1
            sort_num = len(value)
            for sort_type, points in value.iteritems():
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
                ax.plot(xs, ys, colors[j%sort_num]+markers[j%sort_num]+lines[i%num], label=sort_type )
                line_titles.append(sort_type+' '+label)
        ax.set_xlim( (0, x_max*1.1) )
        ax.set_ylim( (0, y_max*1.1) )
        ax.legend(line_titles, loc=4)
    else:
        i = 0
        for label, value in data.iteritems():
            i += 1
            ax = fig.add_subplot(num,1,i)
            ax.grid(True)
            ax.set_title(label)
            j = -1
            x_max = y_max = 0
            for sort_type, points in value.iteritems():
                j += 1
                od_points = collections.OrderedDict(sorted(points.items()))
                if logarithmic:
                    xs = [log(x,10) for x in od_points.keys()]
                    ys = [log(y,10) for y in od_points.values()]
                else:
                    xs = od_points.keys()
                    ys = od_points.values()
                xs.insert(0,0)
                x_max = max(x_max, max(xs))
                ys.insert(0,0)
                y_max = max(y_max, max(ys))
                ax.plot(xs, ys, colors[j%num]+markers[j%num]+'-', label=sort_type )
            ax.set_xlim( (0, x_max*1.1) )
            ax.set_ylim( (0, y_max*1.1) )
            ax.legend(loc=4)
            
    if len(data_2)>0:
        ax = fig.add_subplot(num,1,num)
        ax.grid(True)
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
                ax.plot(xs, ys, colors[j%sort_num]+markers[j%sort_num]+lines[i%num], label=sort_type )
                line_titles.append(name+' '+label)
        ax.set_xlim( (0, x_max*1.1) )
        ax.set_ylim( (0, y_max*1.1) )
        ax.legend(line_titles, loc=4)
    show()