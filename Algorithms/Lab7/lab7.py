# -*- coding: utf-8 -*-
"""
Лабораторна робота №7 з курсу "Теорія алгоритмів"
Спеціальність: Інформаційні управляючі системи та технології

МЕТА: 
    Вивчення застосування жадібних алгоритмів для розв'язання задач складання
    розкладів.
    
ОПИС РОБОТИ:
    Жадібні алгоритми можуть використовуватись для отримання оптимального 
    розв'язку деяких оптимізаційних задач. До них, зокрема, відносяться деякі
    екземпляри задач складання розкладу.
    
    Задача мінімізації зваженої суми часу закінчення робіт формулюється наступним
    чином:
        
        Задача І.
        Є один спільний ресурс (процесор) та n робіт (завдань або процесів),
        які повинні бути виконані на ресурсі. Ресурс не може бути зайнятий
        більш ніж однією роботою одночасно. Для кожної роботи задані length -
        її тривалість та weight - її вага. Для кожної роботи можна обрахувати
        час її закінчення finish, як finish = start + length, де start - час 
        початку роботи, або час закінчення попередньої роботи.
        Мета полягає в тому, щоб мінімізувати зважену суму часу закінчення робіт,
        тобто функцію вигляду: SUM(finish[i]*weight[i] for all i=[1..n])
        
    Ця задача може бути розв'язана оптимально за допомогою жадібних алгоритмів.
    Але при цьому необхідно обрати правильний критерій для впорядкування робіт
    жадібним алгоритмом.
    
    Проте далеко не для всіх задач жадібні алгоритми є коректними. Розглянемо
    наступну задачу:
        
        Задача ІІ.        
        Є один спільний ресурс (процесор) та n робіт (завдань або процесів),
        які повинні бути виконані на ресурсі. Для кожної роботи задані: length 
        (тривалість), weight (вага/пріоритет), deadline (обов'язковий час 
        закінчення). Для кожної роботи можна обрахувати час її закінчення 
        finish, як finish = start + length, де start - час початку роботи, 
        або час закінчення попередньої роботи.
        Запізнення (lateness) для задачі вираховується як 
        lateness = max(0, finish - deadline) і є додатним, якщо задача 
        закінчилась після вказаного дедлайну.
        Мета полягає в тому, щоб мінімізувати зважену суму запізнень робіт,
        тобто функцію вигляду: SUM(lateness[i]*weight[i] for all i=[1..n])
        
    Наразі не відомий жадібний алгоритм, який би розв'язував цю задачу коректно.
    Проте, за допомогою таких алгоритмів можна побудувати наближене рішення, при
    цьому зробити це досить швидко.
        
    
ЗАВДАННЯ:
    1) Розв'язати задачу І різними алгоритмами.
    
    1.1) Реалізувати критерій (weight-length) (див. функцію schedule_dif) та
    (weight/length) (див. функцію schedule_ratio) для розв'язання задачі І за
    допомогою жадібного алгоритму. Порівняти роботу двох критеріїв на тестових
    вироджених прикладах (див. функцію test).
    
    1.2) Порівняти ефективність двох критеріїв на даних різної розмірності. Для
    цього скористатись функцією compare. Пересвідчитись, що критерій різниці
    не є оптимальним.
    
    2) (На додаткові 2 бали) Запропонувати різні критерії сортування робіт для 
    жадібного алгоритму для задачі ІІ (див. функцію minimize_tardiness). 
    Порівняти ефективність різних критеріїв, провівши серію експериментів
    (див. функцію test_tardiness)
    
ДОКУМЕНТАЦІЯ:
    Python v2.7.3 documentation:
        - http://docs.python.org/2/
        - http://oim.asu.kpi.ua/python/docs (дзеркало, доступне з кафедральних комп'ютерів)
    Книга "Dive Into Python":
        - http://www.diveintopython.net/
        - http://oim.asu.kpi.ua/python/diveintopython/html/ (дзеркало, доступне з кафедральних комп'ютерів)
"""

from plot_data import plot_data
from copy import deepcopy
from random import randint

def load_data(file_name, size=None):
    """
    Завантаження робіт з вхідного файлу. 
    Формат файлу:
        Перший рядок - кількість робіт
        Наступні рядки - три числа: 
            weight (вага), length (тривалість), deadline (час обов'язкового закінчення)
    Параметри:
        file_name - ім'я файлу
        size - обмеження вихідного масиву за розміром; якщо None, то на вихід
                повернуться всі роботи з файлу
    Повертає:
        Масив data, який містить вхідні роботи. Формат запису масиву:
            weight - вага роботи
            length - тривалість роботи
            deadline - час обов'язкового закінчення
    """
    data = []
    with open(file_name,'r') as f:
        n = int(f.readline())
        for line in f:
            weight, length, deadline = tuple([int(x) for x in line.split()])
            data.append({'weight':weight, 'length':length, 'deadline':deadline})
    if size and size>=0:
        return data[:size]
    return data
    
def gen_data(n, max_weight=100, max_length=100, deadline_coef=1):
    """
    Функція генерація характеристик робіт (завдань) для складання розкладів.
    Кожне завдання містить три характеристики:
        weight - вага
        length - тривалість
        deadline - обов'язковий час закінчення
    Параметри:
        n - кількість робіт, які будуть згенеровані
        max_weight - максимальна вага
        max_length - максимальна тривалість
    Повертає:
        Згенерований масив робіт
    """
    data = []
    max_deadline = n*max_length
    for i in range(n):
        weight, length, deadline = randint(1,max_weight), randint(1,max_length), randint(max_length,max_deadline//deadline_coef)
        data.append({'weight':weight, 'length':length, 'deadline':deadline})
    return data

def schedule_dif(data):
    """
    Функція реалізує жадібний алгоритм побудови розкладу робіт на основі 
    сортування робіт за зменшенням критерію (weight - length).
    Параметри:
        data - вхідний масив робіт (для опису див. коментарі до функції load_data)
    Повертає:
        Значення зваженої суми.
        
    ЗАВДАННЯ:
        Необхідно реалізувати жадібний алгоритм, який мінімізує зважену суму
        часу закінчення робіт на основі критерію (weight - length). 
        Для деталей - див. розділ 11.3 в електронному конспекті лекцій, тема
        "11. Жадібні алгоритми".
    """
    
    sum = 0
    
    data.sort(key = lambda x: x['weight'] - x['length'], reverse = True)
    t = 0
    
    for e in data:
        t += e['length']
        sum += e['weight'] * t
    
    return sum
    
def schedule_ratio(data):
    """
    Функція реалізує жадібний алгоритм побудови розкладу робіт на основі 
    сортування робіт за зменшенням критерію (weight/length).
    Параметри:
        data - вхідний масив робіт (для опису див. коментарі до функції load_data)
    Повертає:
        Значення зваженої суми.
        
    ЗАВДАННЯ:
        Необхідно реалізувати жадібний алгоритм, який мінімізує зважену суму
        часу закінчення робіт на основі критерію (weight/length). 
        Для деталей - див. розділ 11.3 в електронному конспекті лекцій, тема
        "11. Жадібні алгоритми".
    """
    
    sum = 0
    
    data.sort(key = lambda x: x['weight']/x['length'], reverse = True)
    t = 0
    
    for e in data:
        t += e['length']
        sum += e['weight'] * t
    
    return sum
    
def minimize_tardiness(data, cmp, reverse):
    """
    Функція сортує роботи для складання розкладу із урахуванням мінімізації
    зваженого запізнення (мінімізація суми weight*lateness для кожної роботи).
    Параметри:
        data - вхідний масив робіт (для опису див. коментарі до функції load_data)
        
    ЗАВДАННЯ:
        Необхідно запропонувати вигляд критерію для сортування жадібним алгоритмом
        робіт у вхідному масиві з огляду на мінімізацію зваженого запізнення 
        (суми weight*lateness для кожної роботи).
        
        Функція повинна відсортувати масив data, який далі буде переданий до
        процедури calculate_tardiness, яка проводить остаточне обрахування
        зваженої суми запізнень.
    """
    
    return data.sort(key = cmp, reverse = reverse)
    
def calculate_tardiness(data, cmp, reverse):
    """
    Функція обраховує зважену суму запізнень для робіт, які розміщені в масиві
    data. 
    Параметри:
        data - вхідний масив робіт (для опису див. коментарі до функції load_data)
    Повертає:
        Значення зваженої суми запізнень для робіт
    """
    minimize_tardiness(data, cmp, reverse)
    sum = 0
    t = 0
    for job in data:
        t += job['length']
        l = max(0, t-job['deadline'])
        sum += l*job['weight']
    return sum
    
def compare(data):
    """
    Функція порівнює роботу двох жадібних алгоритмів для розв'язання задачі
    мінімізації зваженої суми часу закінчення робіт, які використовують
    різні критерії для впорядкування робіт (див. функції schedule_dif та 
    schedule_ratio). 
    Порівняння проводиться для задач різної розмірності.
    Параметри:
        data - вхідний масив робіт (для деталей див. коментарі в load_data)
    """
    data_plot = {'dif': {}, 'ratio': {}}
    
    # параметри для проведення експерименту    
    n_begin = 10        # початкова розмірність задачі
    n_end = len(data)   # кінцева розмірність задачі
    n_step = 10         # крок розмірності
    
    for n in range(n_begin,n_end+1,n_step):
        sum_1 = schedule_dif(data[:n+1])
        sum_2 = schedule_ratio(data[:n+1])
        print ("N:", n, "Sum_dif:", sum_1, "Sum_ratio:", sum_2)
        
        data_plot['dif'][n] = sum_1
        data_plot['ratio'][n] = sum_2
        
    plot_data(data_plot, oneplot=True, show_markers=False)
        
def test(data):
    """
    Функція порівнює роботу двох жадібних алгоритмів для розв'язання задачі
    мінімізації зваженої суми часу закінчення робіт, які використовують
    різні критерії для впорядкування робіт (див. функції schedule_dif та 
    schedule_ratio). 
    Параметри:
        data - вхідний масив робіт (для деталей див. коментарі в load_data)
    """
    def display(name, s, data):
        print (name, ": Sum:", s, "Jobs in format [weight,length]:\n\t",)
        print (" ".join('[{0},{1}]'.format(x['weight'],x['length']) for x in data))
        
    data_1 = deepcopy(data)
    sum_1 = schedule_dif(data_1)
    display('Dif', sum_1, data_1)
    
    data_2 = deepcopy(data)    
    sum_2 = schedule_ratio(data_2)
    display('Ratio', sum_2, data_2)
    
def test_tardiness(n=1000, tries=15):
    """
    Тестування різних функцій та вхідних даних для складання розкладу із 
    урахуванням мінімізації зваженого запізнення. Проводиться серія
    експериментів, які відрізняються відносною довжиною делайнів (від 
    найбільшої до найменшної). Для кожного експерименту виводяться результати
    Параметри:
        n - розмірність вхадних даних
        tries - довжина серії експериментів
    """
    
    for i in range(tries):
        print (i+1, "Data size:", n, "Deadline coef:", i+1)
        data = gen_data(n,deadline_coef=int(i+1))
        dedline = calculate_tardiness(data, cmp = lambda x: x['deadline'], reverse = False)
        difDelineAndLength = calculate_tardiness(data, cmp = lambda x: x['deadline'] - x['length'], reverse = True)
        ratioDedlineAndLengthR = calculate_tardiness(data, cmp = lambda x: x['deadline']/x['length'], reverse = True)
        difDelineAndLengthMultR = calculate_tardiness(data, cmp = lambda x: (x['deadline'] - x['length']) * x['weight'], reverse = True)
        ratioWeigthAndLengthR = calculate_tardiness(data, cmp = lambda x: x['weight']/x['length'], reverse = True)
        
        print ("Sort by dedline: ", dedline)
        print("Sort by difference between dedline and length: ", difDelineAndLength)
        print("Sort by ratio between dedline and length: ", ratioDedlineAndLengthR)
        print("Sort by difference between dedline and length multiplaed by weidth: ", difDelineAndLengthMultR)
        print("Sort by ration betwwen weight and length: ", ratioWeigthAndLengthR)
        print ("")
    
def task_1_1():
    """
    Порівняти роботу двох алгоритмів для двох вироджених випадків:
        1) коли всі ваги однакові, а тривалості різні
        2) коли всі тривалості однакові, а ваги різні
    """
    print ("Equal weights")
    data = load_data('test_1.txt')
    test(data)
    
    print ("")
    print ("Equal length")
    data = load_data('test_2.txt')
    test(data)
    
def task_1_2():
    print ("Copmare greedy algorithms for different input sizes")
    data = load_data('jobs_1000.txt')
    compare(data)
    
def task_2():
    print ("Minimize weighted tardiness")
    test_tardiness()

# ЗАВДАННЯ 1.1
task_1_1()

# ЗАВДАННЯ 1.2
task_1_2()

# ЗАВДАННЯ 2
task_2()