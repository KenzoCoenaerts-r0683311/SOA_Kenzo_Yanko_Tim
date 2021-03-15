from django.shortcuts import render
from rest_framework import viewsets
from .models import Reservering
from .serializers import ReserveringSerializer

class ReserveringView(viewsets.ModelViewSet):
    queryset = Reservering.objects.all()
    serializer_class = ReserveringSerializer
