# -*- coding: utf-8 -*-
"""
Created on Mon Apr 24 20:54:37 2017

@author: Саша
"""

import numpy as np
from keras.datasets import cifar10
from keras.models import Sequential
from keras.layers import Dense, Flatten
from keras.layers import Dropout
from keras.layers.convolutional import Conv2D, MaxPooling2D
from keras.utils import np_utils

def load_data():
    (x_train, y_train), (x_test, y_test) = cifar10.load_data()
    
    # Normilize data
    x_train = x_train.astype('float32')
    x_test = x_test.astype('float32')
    
    x_train /= 255
    x_test /= 255
    
    # Categorize output data
    y_train = np_utils.to_categorical(y_train, 10)
    y_test = np_utils.to_categorical(y_test, 10)
    
    return (x_train, y_train, x_test, y_test)

def create_model():
    model = Sequential()
    
    model.add(Conv2D(32, (3, 3), padding = 'same', 
                            input_shape = (32, 32, 3),
              activation = 'relu'))
    model.add(Conv2D(32, (3, 3), activation = 'relu'))
    model.add(MaxPooling2D(pool_size = (2, 2)))
    # Regulization layer
    model.add(Dropout(0.25))
    
    
    model.add(Conv2D(64, (3, 3), padding = 'same',
                            activation = 'relu'))
    model.add(Conv2D(64, (3, 3), activation = 'relu'))
    model.add(MaxPooling2D(pool_size = (2, 2)))
    model.add(Dropout(0.25))
    
    # Convert from matrix to array
    model.add(Flatten()) 
    model.add(Dense(512, activation = 'relu'))
    model.add(Dropout(0.5))
    model.add(Dense(10, activation = 'softmax'))
    
    model.compile(loss = 'categorical_crossentropy', optimizer = 'SGD',
                  metrics = ['accuracy'])
    
    
    return model
    
def dump_data(model):
    model_json = model.to_json()
    with open("model.json", "w") as file:
        file.write(model_json)
    model.save_weights("mnist_model.h5")
    return
    
def load_neuralNetwork(model):
    with open("model.json") as file:
        model = model_from_json(file.read())
    model.load_weights("mnist_model.h5")
    
    model.compile(loss = "categorical_crossentropy",
                  optimizer = "SGD", metrics = ["accuracy"])
    return model
    

def main():
    np.random.seed(42) # For eqvivalent results
    
    x_train, y_train, x_test, y_test = load_data()
    model = create_model()
    
    for i in range(30):
        model.fit(x_train, y_train, batch_size = 32, epochs = 1,
                  verbose = 1, validation_split = 0.1, shuffle = True)
        dump_data(model)
    
    scores = model.evaluate(x_test, y_test, verbose = 0)
    print("Accuracy: %.2f%%" % (scores[1] * 100))
    
    return
    
main()
