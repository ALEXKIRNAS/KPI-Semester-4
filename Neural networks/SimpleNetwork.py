# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 10:58:01 2017
@author: ALEXKIRNAS
"""

import numpy as np
import json, codecs
import time

class Network:
    """ Neural network representation """
    
    def __init__(self, layers = (1, 1), speed = 0.5):
        """ Layers - truple of neurons on each layer
            of network. Example: (10, 5, 5, 1) 
            Input layer - 10 neurons, 
            Hiden_1 - 5 neurons, Hiden_2 - 5 neurons
            Output - 1 neuron 
            
            LogFunc - activation function
        """
        
        self.structure = layers  # Structure of each layer
        self.activationFunc = np.vectorize(lambda x: 1.0 / (1 + np.exp(-x)));  # Activatin function
        self.derivativeFunc = lambda x: x * (1 - x)  # Derivative from activation function
        self.theta = [None]  # Matrix of weights for each layer
        self.a = None  # Activation level from each layer
        self.delta = None  # Error rate for each level
        self.speed = speed  # Speed of learning
        
        # for each layer exclude input layer
        for i in xrange(1, len(layers)):
            # create n * (M+1) matrix (+1 = adding bias) with random floats in range [-1; 1]
            self.theta.append(np.mat(np.random.uniform(-1, 1, (layers[i], layers[i - 1] + 1))))
            #self.theta.append(np.matrix(np.ones((layers[i], layers[i - 1] + 1))))
        
        return
        
    def forwardPropagation(self, X):
        """ Run network with values from input vector X """
        
        self.a = [ X[:] ]
           
        for i in xrange(1, len(self.structure)):
            self.a[i - 1] = np.append(self.a[i - 1], [1])    
                  
            # Multiply matrixes and applying activation function to each number of vector
            mult = np.dot(self.theta[i], self.a[i-1].T)
            self.a.append(np.array(self.activationFunc(mult)))
        
        return self.a[len(self.structure) - 1]
    
    def deltaCalc(self, expected):
        """ Calculating delta for each layer """
        
        n = len(self.structure)
        self.delta = [None] * n
        self.delta[n - 1] = []
        
        for i in xrange(len(expected)):
            curr = self.a[n - 1][i]
            self.delta[n - 1].append(self.derivativeFunc(curr) * (expected[i] - curr))
        self.delta[n - 1] = np.array(self.delta[n - 1])
            
        # From n - 1 to 1 layer    
        for i in xrange(n - 1, 0, -1):
            currDelta = self.delta[i]
            if i != (n - 1):
                currDelta = currDelta[0][:-1]
            
            self.delta[i - 1] = np.array(np.dot(currDelta, self.theta[i]))
            for j in xrange(self.structure[i - 1] + 1):
                self.delta[i - 1][0][j] *= self.a[i - 1][j]
                
        return

    def backPropagation(self, expected):
        """ Updating weigth of network """
        self.deltaCalc(expected)
        
        for i in xrange(len(self.structure) - 1, 0, -1):
            weigthDelta = np.dot(np.reshape(self.a[i - 1], (-1, 1)), self.delta[i])
            self.theta[i] += np.multiply(self.speed, weigthDelta).T[0]
            
        return
    
    def error(self, expected):
        err = 0.0
        #print self.a
        for i in range(len(expected)):
            err += (expected[i] - self.a[len(self.structure) - 1][i]) ** 2
            #err = (expected[i] - self.a[len(self.structure) - 1][i])
                  
        err *= 1.0 / 2
        return err
    
    def teach(self, data, expected, loops = 100, showResults = False):
        """ Teach network on #data with #exeped answer in loops iterations """
        for i in range(loops):
            self.forwardPropagation(data)
            self.backPropagation(expected)
            
            if showResults:
                print self.error(expected)
            self.a = None
            self.delta = None
        return
    
    def readTheta (self, fileName):
        with open(fileName) as inputFile:
            self.theta = json.load(inputFile)
        
        for i in xrange(len(self.theta)):
            if not self.theta[i] is None:
                self.theta[i] = np.matrix(self.theta[i])
                
        return
    
    def dumpTheta (self, fileName):
        
        data = []
        for x in self.theta:
            if not x is None:
                data.append(x.tolist())
            else:
                data.append(x)
        json.dump(data, codecs.open(fileName, 'w', encoding='utf-8'), separators=(',', ':'), sort_keys=True, indent=4)
        return
  

if __name__ == '__main__':
    exaples = [[0, 0],
               [0, 1],
               [1, 0],
               [1, 1]]
    
    answers = [(0,), 
               (1,),
               (1,),
               (0,)]
    
    x = Network((2, 5, 5, 1))
    x.readTheta("Network.json")
    
    start = time.time()
    for age in xrange(100):
        for i in xrange(4):
            x.teach(exaples[i], answers[i])
    
    for i in xrange(4):
        x.teach(exaples[i], answers[i], loops = 1, showResults = True)
    print 'Time: ' + str(time.time() - start)
       
    x.dumpTheta("Network.json")
    