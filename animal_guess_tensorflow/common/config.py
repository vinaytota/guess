import os

DATABASE_HOST = "localhost"
DATABASE_PORT = 3306
DATABASE_USER = "root"
DATABASE_PASSWORD = ""
DATABASE_NAME = "ag_development"

if os.environ.get('TEST_MODE') == '1':
    MODEL_DIR = "test/model"
    TRAINING_FILENAME = "test/data/fake_training.csv"
    TEST_FILENAME = "test/data/fake_test.csv"
else:
    MODEL_DIR = "model"
    TRAINING_FILENAME = "data/training.csv"
    TEST_FILENAME = "data/test.csv"
