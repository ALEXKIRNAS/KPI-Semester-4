# -*- coding: utf-8 -*-
"""
Лабораторна робота №1 з курсу "Теорія алгоритмів"
Спеціальність: Інформаційні управляючі системи та технології

МЕТА: 
    Дослідити поведінку двох алгоритмів сортування: метод бульбашки
    та метод включення.
    
ОПИС РОБОТИ:
    В даній роботі досліджуються два методи сортування: метод бульбашки
    та метод включення. Хоча обидва методи мають однакову асимптотичну
    складність - О(n*n), де n - розмір вхідного масиву, проте вважається, що
    в реальності метод бульбашки працює достатньо повільніше за метод включення.
    Вам пропонується перевірити це самостійно.

ЗАВДАННЯ:
    1) Реалізувати алгоритми сортування методами бульбашки (див. функцію 
    bubble_sort) та включення (див. функцію insertion_sort).
    2) Модифікувати обидва алгоритми так, щоб вони сортували дані у зворотному 
    порядку
    3) Провести тестування алгоритмів на різних наборах даних. Для тестування
    використовується функція generate_data. Тестування проводиться для розмірів
    даних [10, 100, 1000, 10000] та трьох типів вхідних даних (випадково 
    згенеровані вхідні дані, найкращі та найгірші вхідні дані). Порівняти 
    отримані результати тестування.
    4) Знайти спосіб покращити поведінку метода бульбашки, щоб він використовував
    меншу кількість операцій. Реалізувати знайдений спосіб та дійти висновку на
    скільки це вплинуло на якість роботи алгоритму
    
ДОКУМЕНТАЦІЯ:
    Python v2.7.3 documentation:
        - http://docs.python.org/2/
        - http://oim.asu.kpi.ua/python/docs (дзеркало, доступне з кафедральних комп'ютерів)
    Книга "Dive Into Python":
        - http://www.diveintopython.net/
        - http://oim.asu.kpi.ua/python/diveintopython/html/ (дзеркало, доступне з кафедральних комп'ютерів)

"""

import numpy as np
import random
from plot_data import plot_data

def generate_data(n, gen_typ="random"):
    """
    Функція генерації масивів для подальшого сортування.
    Параметри:
        n (int) - кількість елементів масиву
        gen_type (string) - тип згенерованих даних:
            "asc" - відсортований у зростаючому порядку масив 
            "desc" - відсортований у спадаючому порядку масив 
            "random" - послідовність елементів генерується випадкова 
                        (значення за замовчуванням)
                        
    Повертає:
        Масив (list) довжиною n з елементами від 1 до n
    """
    
    if gen_type=="asc":
        a = [i+1 for i in range(n)]
        return a
    elif gen_type=="desc":
        a = [i+1 for i in reversed(range(n))]
        return a
    else:
        a = [i+1 for i in range(n)]
        random.shuffle(a)
        return a
            
def bubble_sort(seq):
    """
    Алгоритм сортування бульбашкою 
    Параметри:
        seq - послідовність для сортування
        
    По закінченню роботи масив seq містить відсортовану послідовність
    На вихід функція повертає кількість порівнянь (op_count) під час роботи 
    алгоритму
    
    ЗАВДАННЯ:
        Вашим завданням є написання тіла функції, яка реалізує алгоритм
        сортування методом бульбашкою за наведеним нижче псевдокодом. 
        При чому під час роботи алгоритму повинні підраховуватись порівняння 
        елементів, які виконує даний метод.
        
    ПСЕВДОКОД:
        repeat
            hasChanged := false
            repeat with index from 1 to itemCount
                if (item at index) > (item at (index + 1))
                    swap (item at index) with (item at (index + 1))
                    hasChanged := true
        until hasChanged = false
    """
    op_count = 0
    
    # Тут повинен бути ваш код
    
    hasChanged = True
    while (hasChanged):
        hasChanged = False
        for i in xrange(1, len(seq)):
            op_count += 1
            if seq[i - 1] < seq[i]:
                hasChanged = True
                seq[i - 1], seq[i] = seq[i], seq[i-1]
    
    # Для перевірки можна вивести відсортований масив
    #print seq
    
    return op_count
    
def bubble_impr_sort(seq):
    """
    Покращений алгоритм сортування бульбашкою 
    Див. завдання №3 на початку файлу, а також функцію bubble_sort
    """
    op_count = 0
    
    # Тут повинен бути ваш код
    hasChanged = True
    iter = 0
    while (hasChanged):
        hasChanged = False
        for z in xrange(1, len(seq) - iter):
            op_count += 1
            if(seq[z - 1] < seq[z]):
                hasChanged = True
                seq[z - 1], seq[z] = seq[z], seq[z-1]
        iter += 1
        
         
    
    # Для перевірки можна вивести відсортований масив
    #print seq
    
    return op_count

def insertion_sort(seq):
    """
    Алгоритм сортування включенням 
    Параметри:
        seq - послідовність для сортування
        
    По закінченню роботи масив seq містить відсортовану послідовність
    На вихід функція повертає кількість порівнянь (op_count) під час роботи 
    алгоритму
    
    ЗАВДАННЯ:
        Вашим завданням є написання тіла функції, яка реалізує алгоритм
        сортування методом включення за наведеним нижче псевдокодом. 
        При чому під час роботи алгоритму повинні підраховуватись порівняння 
        елементів, які виконує даний метод.
        
    ПСЕВДОКОД:
        for index_j from 2 to array_length
            key := item at index_j
            index_i := index_j - 1
            while (index_i>0) and (item at index_i)>key
                item at (index_i + 1) := item at index_i
                decrement index_i
            item at (index_i + 1) := key

    """
    op_count = 0
    
    # Тут повинен бути ваш код
    
    for i in xrange(1, len(seq)):
        key = seq[i]
        index = i - 1
        op_count += 1
        while(index >= 0 and seq[index] < key):
            op_count += 1
            seq[index + 1] = seq[index]
            index -= 1
        seq[index + 1] = key
        
    
    # Для перевірки можна вивести відсортований масив
    #print seq
    
    return op_count

"""
ТЕСТУВАННЯ АЛГОРИТМІВ:
    тестування проводиться на наборах розімром 10, 100, 1000, 10000 (масив sizes)
    але для початкової перевірки роботи рекомендується використовувати тільки 
    перші дві-три величини
"""

sizes = [10, 100, 1000, 10000]
types = ["random", "asc", "desc"]
data_plot = {'random': {'bubble':{}, 'insertion':{}, 'bubble_impr':{}}, 
             'asc': {'bubble':{}, 'insertion':{}, 'bubble_impr':{}},
             'desc': {'bubble':{}, 'insertion':{}, 'bubble_impr':{}}}
             
for n in sizes:
    print "\nDATA SIZE: ", n
    
    for gen_type in types:
        print "\n\tDATA TYPE:", gen_type
        data = generate_data(n, gen_type)
        
        data_bubble = np.copy(data)
        bubble_op_count = bubble_sort(data_bubble)
        print "\tBubble sort operation count:", int(bubble_op_count)
        data_plot[gen_type]['bubble'][n] = bubble_op_count
        
# Розкоментуйте наступні рядки для тестування покращеного методу бульбашки
        data_bubble_impr = np.copy(data)
        bubble_impr_op_count = bubble_impr_sort(data_bubble_impr)
        print "\tImproved bubble sort operation count:", int(bubble_impr_op_count)
        data_plot[gen_type]['bubble_impr'][n] = bubble_impr_op_count
    
        data_insertion = np.copy(data)
        insertion_op_count = insertion_sort(data_insertion)
        print "\tInsertion sort operation count:", int(insertion_op_count)
        data_plot[gen_type]['insertion'][n] = insertion_op_count
        
#Побудова графіків швидкодії алгоритмів
plot_data(data_plot, logarithmic=True, oneplot=True)
