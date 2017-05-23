# -*- coding: utf-8 -*-
"""
Лабораторна робота №6 з курсу "Теорія алгоритмів"
Спеціальність: Інформаційні управляючі системи та технології

МЕТА: 
    Вивчення та дослідження бінарних дерев пошуку.
    
ОПИС РОБОТИ:
    Бінарні дерева пошуку (binary search trees) являють собою бінарні дерева,
    які мають наступну властивість. Для кожного піддерева вигляду
                    R
                   / \ 
                  A   B
    виконується A <= R <= B.
    
ЗАВДАННЯ:
    1) Перетворити задане бінарне дерево у бінарне дерево пошуку (для якого
    виконується вище наведена властивість). При цьому зберігти внутріншню 
    структуру дерева (тобто зв'язок між вузлами-батьками та вузлами-синами).
    Для цього реалізувати метод rebuild_bst класу MyBinaryTree (етапи алгоритму
    див. в описі зазначеного методу).
    
    2) (На додатковий 1 бал) Для заданого числа S знайти в бінарному дереві
    пошуку всі такі шляхи (які не обов'язково йдуть від кореня, але всі
    прямують знизу вгору), що сума значень вузлів, які належать знайденим шляхам,
    дорівнює числу S. Для цього реалізувати метод get_sum класу MyBinaryTree.
    
ДОКУМЕНТАЦІЯ:
    Python v2.7.3 documentation:
        - http://docs.python.org/2/
        - http://oim.asu.kpi.ua/python/docs (дзеркало, доступне з кафедральних комп'ютерів)
    Книга "Dive Into Python":
        - http://www.diveintopython.net/
        - http://oim.asu.kpi.ua/python/diveintopython/html/ (дзеркало, доступне з кафедральних комп'ютерів)
"""

class TreeNode:
    """
    Клас TreeNode зберігає вузол бінарного дерева.
    Властивості:
        value - ключ вузла
        parent - покажчик на батьківський вузол
        left - покажчик на лівого нащадка
        right - покажчик на правого нащадка
    Методи:
        delete - звільнює пам'ять, яку використовував поточний вузол
    """
    def __init__(self, value=None, parent=None, left=None, right=None):
        """
        Конструктор класу. Визначає та ініціалізує властивості.
        """
        self.value = value
        self.parent = parent
        self.left = left
        self.right = right
        
    def delete(self):
        """
        Метод видаляє поточний вузол та всі вузли, які є нащадками даного вузла
        """
        if self.left:
            self.left.delete()
            del self.left
        if self.right:
            self.right.delete()
            del self.right
        del self.value
        
    def inOrderTree(self):
        oreder = []
        if self.left:
            oreder += self.left.inOrderTree()
            
        oreder.append(self.value)
        
        if self.right:
            oreder += self.right.inOrderTree()
            
        return oreder
        
    def setInPostOrderPass(self, values):
        assert len(values) != 0
        
        if self.right:
            self.right.setInPostOrderPass(values)
            
        self.value = values[-1]
        values.pop()
        
        if self.left:
            self.left.setInPostOrderPass(values)
            
        return None
        
    def nodeSum(self, s, acum, otherAcum):
        res = []
        
        for item in otherAcum:
            if acum + self.value - item[0] == s:
                res.append((item[1], self))
        
        if self.value == s:
            res.append((self, self))
        otherAcum.append((acum, self))
        acum += self.value
        
        if self.left:
            res += self.left.nodeSum(s, acum, otherAcum)
        if self.right:
            res += self.right.nodeSum(s, acum, otherAcum)
        
        otherAcum.pop()
        return res
        
        
class BinaryTree(object):
    """
    Клас бінарного дерева.
    Властивості:
        root - покажчик на корінь дерева (тип TreeNode)
    Методи:
        del_tree - видаляє дерево
        load_tree - завантажує дерево з файлу
        display_horizontal - друкує дерево горізонтально
        display_vertical - друкує дерево вертикально
    """
    def __init__(self):
        """
        Конструктор класу. Визначає та ініціалізує властивості.
        """
        self.root = None
        
    def del_tree(self):
        """
        Метод видаляє дерево з пам'яті
        """
        if self.root:
            self.root.delete()
            del self.root
            self.root = None
        
    def load_tree(self, file_name):
        """
        Завантажує дерево з файлу
        Параметри:
            file_name - ім'я текстового файлу; містить запис дерева у 
                        внутрішньому порядку
        """
        string = ''
        with open(file_name,'r') as f:
            string = f.readline()
            
        self.del_tree()
        blocks = string.split()
        cur_parent = None
        is_left = True
        for block in blocks:
            if not self.root:
                self.root = TreeNode(int(block))
                cur_parent = self.root
            else:
                if block=="None":
                    if is_left:
                        is_left = False
                    else:
                        while cur_parent.parent and cur_parent.parent.right==cur_parent:
                            cur_parent = cur_parent.parent
                        cur_parent = cur_parent.parent
                else:
                    new_node = TreeNode(int(block), cur_parent)
                    if is_left:
                        cur_parent.left = new_node
                    else:
                        cur_parent.right = new_node
                    cur_parent = new_node
                    is_left = True
                if not cur_parent:
                    break
                
    def display_horizontal(self):
        """
        Відображає дерево горізнотально. 
        Наприклад:
            1
            L-- 2
            R-- 3
                R-- 4
        """

        def display_node(node, indent):
            if node.parent:
                print ('{}-- {}'.format('   '.join(x for x in indent), node.value))
            else:
                print (node.value)
            indent = indent.replace('R',' ')
            if node.parent and node.parent.left==node:
                if node.parent.right:
                    indent = indent.replace('L','|')
                else:
                    indent = indent.replace('L',' ')
            if node.left:
                display_node(node.left, indent + 'L')
            if node.right:
                display_node(node.right, indent + 'R')
        
        display_node(self.root, '')
        
    def display_vertical(self):
        """
        Відображає дерево вертикально. 
        Наприклад:
                      [1 ] 
                 +-----++-----+     
                [2 ]        [3 ]    
                              +--+  
                               [4 ] 
        """
        if not self.root:
            return
        
        # find max width
        def max_value(node, depth):
            if node==None:
                return 0, depth
            else:
                ml, dl = max_value(node.left, depth+1)
                mr, dr = max_value(node.right, depth+1)
                return max(node.value, ml, mr), max(depth+1, dl, dr)
        max_v, max_d = max_value(self.root, 0)
        max_d -= 1
        basic_width = len(str(max_v))
        if basic_width%2:
            basic_width += 1
        basic_str = ' [{:^' + str(basic_width) + '}] '
        basic_width += 4
        area = [''] * (max_d*2 + 1)
        area[0] = ' '*((2**(max_d-1))*basic_width - basic_width//2) + basic_str.format(self.root.value)
        stack = [(self.root.right,1), (self.root.left,1)]
        while stack:
            node, d = stack.pop()
            if node:
                ind = -basic_width//2
                if d<max_d:
                    ind += 2**(max_d-d-1)*basic_width  
                if ind>0:
                    area[2*d] += ' '*ind
                area[2*d] += basic_str.format(node.value)
                if ind>0:
                    area[2*d] += ' '*ind
                if node.parent.left==node:
                    if ind>0:
                        area[2*d-1] += ' '*ind
                    area[2*d-1] += ' '*(basic_width//2 - 1) + '+-' + '-'*(basic_width//2 - 2)
                    if ind>0:
                        area[2*d-1] += '-'*ind
                    area[2*d-1] += '+'
                if node.parent.right==node:
                    area[2*d-1] += '+'
                    if ind>0:
                        area[2*d-1] += '-'*ind
                    area[2*d-1] += '-'*(basic_width//2 - 2) + '-+' + ' '*(basic_width//2 - 1)
                    if ind>0:
                        area[2*d-1] += ' '*ind
            else:
                area[2*d] += ' '*(2**(max_d-d))*basic_width
                area[2*d-1] += ' '*(2**(max_d-d))*basic_width

            if d<max_d:
                if node:
                    stack += [(node.right,d+1), (node.left,d+1)]
                else:
                    stack += [(None,d+1), (None,d+1)]
        print ('\n'.join(s for s in area))
        
class MyBinaryTree(BinaryTree):
    """
    Клас бінарного дерева пошуку.
    Базовий клас: BinaryTree
    
    ЗАВДАННЯ:
        Необхідно наповнити наведені нижче методи класу MyBinaryTree:
            rebuild_bst, get_sum
    """
    
    def rebuild_bst(self):
        """
        Метод перетворює поточне бінарне дерево у бінарне дерево пошуку, 
        причому зберігається внутрішня структура дерева.
        
        УВАГА:
            Метод можна реалізувати за наступним алгоритмом:
                1. Обійти дерево у внутрішньому порядку та зберігти всі значення 
                в масиві.
                2. Відсортувати масив у зростаючому порядку.
                3. Знову обійти дерево у внутрішньому порядку та послідовно
                вписати значення з відсортованого масиву у вузли дерева за
                порядком обходу.
        """
        inOrderNodes = self.root.inOrderTree()
        inOrderNodes.sort()
        self.root.setInPostOrderPass(inOrderNodes)
        
        
    def get_sum(self, s):
        """
        Метод шукає всі шляхи у бінарному дереві пошуку, значення вузлів в яких
        дорівнює сумі, яка передається у вигляді параметру. Це можуть бути
        будь-які шляхи (не тільки з кореня)
        Параметри:
            s - сума, яку необхідно знайти в дереві
        
        УВАГА:
            Записуйте знайдені шляхи в масив self.paths. 
            Кожнй шлях представляйте у вигляді масиву значень вузлів. Наприклад:
                [1, 2, 3]
        """
                
        self.paths = []
        
        nodes = self.root.nodeSum(s, 0, [])
        for parent, node in nodes:
            path = []
            while node != parent:
                path.append(node.value)
                node = node.parent
            path.append(node.value)
            self.paths.append(path[::-1])
        
        if self.paths:
            print ("\nSum paths for", s, ':')
            print ('\n'.join(' -> '.join(str(x) for x in path) for path in self.paths))
        else:
            print ('\nSum paths for', s, 'not found')
        
tree = MyBinaryTree()
tree.load_tree('tree_8.txt')

#Завдання 1
print ("Original tree:")
tree.display_vertical()
tree.rebuild_bst()
print ("\nObtained binary search tree:")
tree.display_vertical()

#Завдання 2
tree.get_sum(7)