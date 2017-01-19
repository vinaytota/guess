Setup

Requires python+pip, I tested on Ubuntu 16.0.4 Xenial Xerus with Python 2.7.12

These instructions describe how to install the dependencies globally for the sake of simplicity, but you can create a virtualenv also.

1. `pip install requirements.txt`
2. Make sure config.py has the correct values for connecting to the database
3. Write db data into CSV: `python -m scripts.db_to_csv`
4. Train on CSV data: `python -m scripts.train`
5. `python -m scripts.server`

The last step starts a tiny HTTP server which provides access to the model over an HTTP/JSON interface

Example request:
`http://localhost:5000/?height=50&weight=110`

Example response:
`{"favorite_animal_guess_id": 1}`

The "real" way to serve a Tensorflow model is to use https://tensorflow.github.io/serving/
However for the sake of this project that would have been overkill, and more significantly would 
have made setup of this app much more difficult. Consequently we use a tiny 
Flask wrapper app to call the Tensorflow python API instead.
