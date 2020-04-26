from django.db import models

class Counter(models.Model):
    count = models.IntegerField(default=0)


class Person(models.Model):
    name = models.CharField(max_length=255)
