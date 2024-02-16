from flask import Flask, request
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
import nltk
from nltk.corpus import stopwords
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
import string

app = Flask(__name__)

@app.route('/predict_star_rating', methods = ['GET'])
def predict_star_rating():
    data = pd.read_csv("yelp.csv")

    data['length'] = data['text'].apply(len)

    data_classes = data[(data['stars']==1)| (data['stars']==2) | (data['stars']==3) | (data['stars']==4) | (data['stars']==5)]

    x = data_classes['text']
    y = data_classes['stars']

    vocab = CountVectorizer(analyzer=text_process).fit(x)

    x_train,x_test,y_train,y_test = train_test_split(x,y,test_size=0.2,random_state=101)

    
    svm = SVC(random_state=101)
    svm.fit(x_train,y_train)

    rr= "the restaurant was so lively. it has the atmosphere of fine dining yet keeping things so simple. The food was so delicious from appetizers to desserts. The prices are also modest so that an average person can afford. Top class."
    rr_t=vocab.transform([rr])
    svm.predict(rr_t)[0]
    


def text_process(text):
    nopunc = [char for char in text if char not in string.punctuation]
    nopunc = ''.join(nopunc)
    return [word for word in nopunc.split() if word.lower() not in stopwords.words('english')]
