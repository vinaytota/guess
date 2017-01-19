import urllib2
import json
import sys

test_file = open('test/data/fake_test.csv')

correct_guesses = 0
total_guesses = 0
for line in test_file:
    data = line.split(',')
    height = data[0]
    weight = data[1]
    expected_result = int(data[-1])
    guess_id = json.load(
        urllib2.urlopen(
            "http://localhost:5000?height=%s&weight=%s" % (height, weight)
        )
    )["favorite_animal_guess_id"]

    total_guesses += 1
    if guess_id - 1 == expected_result:
        correct_guesses += 1

accuracy = float(correct_guesses)/float(total_guesses)

if accuracy >= 0.97:
    print("Accuracy of %s greater than expected 97%% accuracy, tests pass!" % accuracy)
else:
    print("Accuracy of %s did not meet 97%% threshold, tests fail :(" % accuracy)
    sys.exit(1)