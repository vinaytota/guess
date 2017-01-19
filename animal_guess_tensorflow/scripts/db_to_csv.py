import MySQLdb
import common.config as config
import common.features as features

try:
    db = MySQLdb.connect(
        host=config.DATABASE_HOST,
        user=config.DATABASE_USER,
        passwd=config.DATABASE_PASSWORD,
        db=config.DATABASE_NAME)

    cur = db.cursor()
    num_rows = cur.execute(
        "SELECT height, weight, animal_id FROM favorite_animals WHERE animal_id IS NOT NULL")

    print("Total data rows: %s" % num_rows)

    training = open(config.TRAINING_FILENAME, "w")
    training.truncate()
    test = open(config.TEST_FILENAME, "w")
    test.truncate()

    i = 0
    features_fmt = "%s," * features.NUM_FEATURES
    for row in cur:
        height = row[0]
        weight = row[1]
        # tensorflow likes it's categories 0 indexed
        favorite_animal_id = int(row[2]) - 1
        feature_tuple = features.get_features(height, weight)

        output_string = (features_fmt % feature_tuple) + "%s\n" % favorite_animal_id

        # 70 % of data into training set
        if i % 10 < 7:
            training.write(output_string)
        # other 30 % into test set
        else:
            test.write(output_string)
        i += 1
finally:
    db.close()
    training.close()
    test.close()
