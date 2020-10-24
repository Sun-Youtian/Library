
from django.contrib import admin
from django.urls import path, include
from MyApp import views as App_views, view_test

urlpatterns = [
# 前半部分是匹配搜索框内容，后半部分匹配view.py文件下的函数
    path('MyApp/',include('MyApp.urls')),
    path('admin/', admin.site.urls),

    path('new_login/', view_test.new_login),
]

