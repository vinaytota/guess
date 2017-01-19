import json

import numpy as np
from flask import Flask, request

from common.classifier import CLASSIFIER
from common.features import get_features


classifier = CLASSIFIER


'''
y = list(classifier.predict(new_samples, as_iterable=True))
print('Predictions: {}'.format(str(y)))
'''
app = Flask(__name__)


@app.route("/")
def guess():
    height = int(request.args.get('height'))
    weight = int(request.args.get('weight'))
    features = get_features(height, weight)

    np_features = np.array([features], dtype=float)
    favorite_animal_guess = list(classifier.predict(np_features, as_iterable=True))[0]
    # map back from 0 indexed tf classes to 1 indexed app
    favorite_animal_guess += 1
    return json.dumps({"favorite_animal_guess_id": favorite_animal_guess}), \
        200, {'Content-Type': 'application/json'}


if __name__ == "__main__":
    app.run(host="0.0.0.0")
