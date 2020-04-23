from django.shortcuts import render

from .models import Counter

def index(request):
    counter = Counter.objects.last()
    if not counter:
        counter = Counter.objects.create()

    counter.count +=1
    counter.save()
    context = {
        "count": counter.count,
    }
    return render(request, 'counter/index.html', context)
