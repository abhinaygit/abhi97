This is a machine learning project which I have done in my Master's. 

In this project, I will apply Machine Learning methods to classify fake re- views from real reviews. The dataset is a real-world dataset which contains real reviews from tripadvisor and fake reviews written by paid Amazon Mechanical Turk Workers. It is a standard binary classification prob- lem. The training, validation and test datasets of reviews are provided. Each review is in a single line and the corresponding label is provided in a different file. There are 6 files, train.txt, test.txt and validation.txt that contains the reviews and trainlabels.txt, testlabels.txt and validationlabels.txt that contain the labels (1 denotes a fake review and 0 a real review). You will apply the full ML pipeline, i.e., feature extraction, fine-tuning ML algorithms and evaluation for this dataset.

Feature Extraction: To perform feature extraction, I used a state-of- the-art language representation model called Word2Vec that is based on neural networks. Gensim is an open-source software package for this model that allows us to easily convert any document to real-valued vectors. Internally it uses a neural network architecture to do this. 
Note: In real-life you will use pre-trained models that have been trained on millions of examples to generate the vectors.

ML Algorithms: Used 3 algorithms in my implementation, Neural Net- works, Logistic regression and Random Forests. Used the standard sklearn libraries for this. Used the validation dataset to tune the parameters to obtain as best performance as possible. That is, train on the training dataset and maximize the F1-score on the validation dataset by experimenting with different settings in the algorithms. 
E.g. for Neural-Nets vary the hidden-layer units, for Logistic Regression change the regularization and for Random Forests change the number of decision trees used and the depth of these trees.

Evaluation: Evaluated performance on the test dataset for the optimal model parameters. Computed the precision, recall and F1-score.
The logistic regresssion classifier serves the best purpose to evaluate the dataset with higher precision and accuracy. We can also see the F1_score which proves this is the best classifier amongst the other three.
