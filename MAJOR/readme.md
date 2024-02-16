The goal of the project is to conduct sentimental analysis on Yelp reviews of some
restaurants in United States. By this analysis we will help those business to find out their
value in the market.


In this project we are going to conduct sentimental analysis on yelp customer reviews on
different restaurants in USA with using various machine learning algorithms. Going
forward we will analyze the reviews as different emotions and assign a category for each
review. Natural language processing will be an important part of this analysis. For
example, any restaurant can find their top 10 positive or negative reviews which will
definitely help to improve their business.

Sentimental Analysis:

Sentiment analysis involves using natural language processing techniques to determine the emotional 
tone of a piece of text. Feature engineering for sentiment analysis involves selecting and transforming 
the relevant features in the data to improve the performance of the sentiment analysis model. 
Here are some steps for feature engineering for sentimental analysis of the Yelp dataset:

Data Preprocessing: Before any feature engineering, the Yelp dataset needs to be preprocessed. 
This includes steps like removing stop words, punctuation, and special characters. 
The text data can also be converted to lowercase to avoid duplicate features.

Tokenization: Tokenization is the process of breaking down the text into individual words or phrases. 
This can be done using various techniques like word-level tokenization, character-level tokenization, 
or sub word tokenization. Tokenization is an essential step in feature engineering, as it forms the basis for creating meaningful features.

Vectorization: Vectorization involves transforming the text data into a numerical format that can be 
used as input to a machine learning algorithm. There are several techniques for vectorization, 
including count-based vectorization, TF-IDF (Term Frequency-Inverse Document Frequency) vectorization, 
and word embeddings. Count-based vectorization involves counting the frequency of each word in a 
document, while TF-IDF vectorization considers the frequency of words across all documents. 
Word embeddings use neural networks to map words to a high-dimensional vector space, where 
words with similar meanings are close to each other.

Feature Selection: Feature selection involves selecting the most relevant features from the 
vectorized data. This is done to reduce the dimensionality of the data and improve the performance 
of the sentiment analysis model. There are several techniques for feature selection, 
including chi-square tests, mutual information, and recursive feature elimination.

N-grams: N-grams are contiguous sequences of n items from a given sample of text or speech.
In the case of sentimental analysis, n-grams can be used to capture the relationship between 
adjacent words in a sentence. For example, bigrams (n=2) can capture the relationship 
between pairs of words, while trigrams (n=3) can capture the relationship between groups 
of three words. N-grams can be used as features in the sentiment analysis model.

Part-of-speech (POS) Tagging: POS tagging is the process of identifying the part of speech
of each word in a sentence. POS tagging can be used to extract features like the number of 
nouns, adjectives, and verbs in a sentence. This information can be used to improve the 
performance of the sentiment analysis model.

Overall, feature engineering is an iterative process that involves experimenting with different 
techniques and evaluating their performance on a validation set. The goal is to create a set of 
features that capture the relevant information in the text data and improve the accuracy of the sentiment analysis model.

