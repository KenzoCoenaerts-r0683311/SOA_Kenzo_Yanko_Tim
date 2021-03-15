from rest_framework import serializers
from .models import  Reservering

class ReserveringSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reservering
        fields = ('id', 'naam', 'datumTijd')
