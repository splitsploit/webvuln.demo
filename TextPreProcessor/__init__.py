from sklearn.pipeline import TransformerMixin
import re

class TextInputProcessor(TransformerMixin):
    def __init__(self):
        pass

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        X_ = []
        for i in X:
            tmp = re.sub(r'\s+', ' ', i)
            tmp = tmp.lower().strip()
            X_.append(tmp)
        return X_
