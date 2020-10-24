from django.http import HttpResponse
from django.shortcuts import render
from MyApp.models import User,Student,Seat,Readroom,Book,Blacklist

def new_login(request):#登入
        return render(request, 'new_login.html')
