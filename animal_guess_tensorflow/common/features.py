import math

NUM_FEATURES = 4


def get_features(height, weight):
    bmi = 703.0704 * float(weight) / math.pow(float(height), 2)

    if bmi < 18.5:
        bmi_category = 1
    elif bmi < 25:
        bmi_category = 2
    elif bmi < 30:
        bmi_category = 3
    elif bmi < 35:
        bmi_category = 4
    else:
        bmi_category = 5

    return (height, weight, bmi, bmi_category)
