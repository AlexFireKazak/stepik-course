from django.urls import path

from . import views

urlpatterns = [
    path(r'^$', views.test),
    path(r'^login/.*$', views.test),
    path(r'^signup/.*$', views.test),
    path(r'^question/\/d+/$', views.test),
    path(r'^ask/.*$', views.test),
    path(r'^popular/>*$', views.test),
    path(r'^new/>*$', views.test),
]