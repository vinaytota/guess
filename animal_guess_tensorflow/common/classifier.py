import tensorflow as tf

from common.features import NUM_FEATURES
from common.config import MODEL_DIR

feature_columns = [
    tf.contrib.layers.real_valued_column("", dimension=NUM_FEATURES)
]


CLASSIFIER = tf.contrib.learn.LinearClassifier(
    feature_columns=feature_columns,
    optimizer=tf.train.GradientDescentOptimizer(
        learning_rate=0.1
    ),
    model_dir=MODEL_DIR)

# Fancy training algorithm google came up with called FTRL
# https://www.eecs.tufts.edu/~dsculley/papers/ad-click-prediction.pdf
"""
CLASSIFIER = tf.contrib.learn.LinearClassifier(
    feature_columns=feature_columns,
    optimizer=tf.train.FtrlOptimizer(
        learning_rate=0.1,
        l1_regularization_strength=1.0,
        l2_regularization_strength=1.0),
    model_dir=MODEL_DIR)
"""


# Build 3 layer DNN with 10, 20, 10 units respectively.
"""
CLASSIFIER = tf.contrib.learn.DNNClassifier(feature_columns=feature_columns,
                                            hidden_units=[10, 20, 10],
                                            n_classes=2,
                                            model_dir="/tmp/iris_model")
"""
