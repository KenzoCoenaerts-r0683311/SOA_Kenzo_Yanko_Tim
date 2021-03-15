from django.db import models

class Reservering(models.Model):
    naam = models.CharField(max_length=50)
    datumTijd = models.DateTimeField()
