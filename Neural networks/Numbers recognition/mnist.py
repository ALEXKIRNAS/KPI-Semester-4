# -*- coding: utf-8 -*-
"""
Created on Sun Apr 23 16:36:47 2017

@author: Саша
"""

# matrix operations
import numpy as np  
# neural network model
from keras.models import Sequential  
# neural network layer (all on prev level conected with all on curr level)
from keras.layers import Dense  
# Utilites for arrays
from keras.utils import np_utils
from keras.datasets import mnist
from keras.models import model_from_json


def prepareData():
    # Loading data
    (x_train, y_train), (x_test, y_test) = mnist.load_data()
     
    datasetSize = 60000
    imageSize = 28 * 28
    
    # conver image from matrix to array
    x_train = x_train.reshape(datasetSize, imageSize)
    x_test = x_test.reshape(datasetSize // 6, imageSize)
    # normalize data
    x_train = x_train.astype('float32')
    x_train /= 255
    
    x_test = x_test.astype('float32')
    x_test /= 255
    
    y_train = np_utils.to_categorical(y_train, 10)
    y_test = np_utils.to_categorical(y_test, 10)
    return (x_train, y_train, x_test, y_test)

def prepareModel(): 
    model = Sequential()
    
    #Adding layers
    model.add(Dense(800, input_dim = 28 * 28, kernel_initializer="normal",
                    activation = "relu"))
    model.add(Dense(10, kernel_initializer="normal", activation = "softmax"))
    
    #Compiling model
    model.compile(loss = "categorical_crossentropy",
                  optimizer = "SGD", metrics = ["accuracy"])
    
    return model

def saveModel(model):
    model_json = model.to_json()
    with open("model.json", "w") as file:
        file.write(model_json)
    model.save_weights("mnist_model.h5")
    
    return

def loadModel():
    with open("model.json") as file:
        model = model_from_json(file.read())
    model.load_weights("mnist_model.h5")
    
    model.compile(loss = "categorical_crossentropy",
                  optimizer = "SGD", metrics = ["accuracy"])
    return model
    

def main():
    x_train, y_train, x_test, y_test =  prepareData()
    
    #model = prepareModel()
    model = loadModel()
    
    model.fit(x_train, y_train, batch_size = 200, epochs = 50, 
              validation_split = 0.2, verbose = 1)
    
    scores = model.evaluate(x_test, y_test, verbose=0)
    print("Точность работы на тестовых данных: %.2f%%" % (scores[1]*100))
    saveModel(model)
    return

main()
    