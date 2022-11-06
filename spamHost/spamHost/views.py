from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
import joblib

from TextPreProcessor import TextInputProcessor


# Create your views here.
# exempt csrf
@csrf_exempt
def predict(request):
    if request.method == 'GET':
        return JsonResponse({
            "message" : "Not supported"
        }, status = 400)

    with open('./static/spam_model.pkl', 'rb') as f:
        spamModel = joblib.load(f)
    
    text = request.POST.get("text")

    if text is None:
        return JsonResponse({
            "message" : "Bad Request"
        }, status = 400)


    preds = spamModel.predict([text])
    preds = ["Spam" if i == 1 else "Ham" for i in preds]

    return JsonResponse({
            "prediction" : preds
        }, status = 200)
