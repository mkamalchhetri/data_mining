
import numpy as np
import pandas as pd
import tensorflow as tf
from sklearn.model_selection import train_test_split


# Reading CSV File
data = pd.read_csv("../data/mushrooms.csv")


data['type'] = data['type'].apply(lambda label: int(label == 'p'))
data = data.drop('veil_type', axis=1)
print(data.columns)


def neural_nets():
    x_data = data.drop('type', axis=1)
    y_data = data['type']
    x_train, x_test, y_train, y_test = train_test_split(x_data, y_data, test_size= 0.35)

    # create feature columns with tf.estimator
    cap_shape = tf.feature_column.categorical_column_with_hash_bucket('cap_shape', hash_bucket_size=6)

