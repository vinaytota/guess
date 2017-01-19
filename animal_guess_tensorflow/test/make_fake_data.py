import random

import common.features as features


training = open("test/data/fake_training.csv", "w")
training.truncate()
test = open("test/data/fake_test.csv", "w")
test.truncate()

features_fmt = "%s," * features.NUM_FEATURES
for i in xrange(1000):
    # make up some fake data
    # (height and weight are of course not independent!)
    height = int(random.gauss(66, 3))
    weight = int(random.gauss(150, 30))

    # let's make things easy . . .
    if weight < 150.0:
        favorite_animal = 0
    else:
        favorite_animal = 1

    feature_tuple = features.get_features(height, weight)
    output_string = (features_fmt % feature_tuple) + "%s\n" % favorite_animal

    if i % 10 < 7:
        training.write(output_string)
    # other 30 % into test set
    else:
        test.write(output_string)
