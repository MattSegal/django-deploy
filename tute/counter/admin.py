from django.contrib import admin

from counter.models import Counter, Person

admin.site.register(Counter)
admin.site.register(Person)
