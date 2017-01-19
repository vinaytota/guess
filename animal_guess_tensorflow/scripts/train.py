import sys
import shutil

import tensorflow as tf
import numpy as np

from common.classifier import CLASSIFIER
import common.config as config

training_csv = config.TRAINING_FILENAME
test_csv = config.TEST_FILENAME

# delete model for clean build
try:
    shutil.rmtree(config.MODEL_DIR)
except:
    pass

# Load datasets.
training_set = tf.contrib.learn.datasets.base.load_csv_without_header(
    filename=training_csv,
    target_dtype=np.int,
    features_dtype=np.float)
test_set = tf.contrib.learn.datasets.base.load_csv_without_header(
    filename=test_csv,
    target_dtype=np.int,
    features_dtype=np.float)

classifier = CLASSIFIER

# Fit model.
classifier.fit(x=training_set.data,
               y=training_set.target,
               steps=2000)

# Evaluate accuracy.
accuracy_score = classifier.evaluate(x=test_set.data,
                                     y=test_set.target)["accuracy"]
print('Accuracy: {0:f}'.format(accuracy_score))
