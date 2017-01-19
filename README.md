`animal_guess`
A MySQL backed Rails 5.0.1 app (tested on Ubuntu with Ruby 2.3.1p112)

Calls the HTTP service in `animal_guess_tensorflow` for favorite pet predictions

`rake db:seed` creates some training based on https://www.kaggle.com/miroslavsabo/young-people-survey

Participants in this study reported their weight and height, as well as if they were scared of dogs
on a scale from 1 - 5. Using this data, it was assumed anyone not scared of dogs had dogs as their favorite
animal and anyone who was scared of dogs had cats as their favorite animals.

`animal_guess_tensorflow`
Small set of Python scripts using Tensorflow to get data from Rails DB and train a simple
linear classifier model on that data. The model is made accessible via a small HTTP service. As you might
guess the accuracy of this model is pretty bad (I observed 55% accuracy on a subset of the aforementioned data).
Python seems to have a flourishing ecosystem of ML libraries, so it's probably inevitable this piece had to be
written in Python, but could have been done with an ML library other than Tensorflow.