import pickle
import re
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer, TfidfTransformer
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import FunctionTransformer
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.metrics import classification_report, confusion_matrix


def cleanText(text):
    # remove newline
    text = re.sub(r'\s+', ' ', text)
    return text.lower().strip()

def textPreprocess(st):
    return [cleanText(i) for i in st]

def getSpamModel():
    textInputProcessor = FunctionTransformer(textPreprocess)

    with open('./spam_model.sav', 'rb') as f:
        spamModel = pickle.load(f)
    return spamModel