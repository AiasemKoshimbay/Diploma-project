from . import views
from django.urls import path
from .views import TelegramBotView

urlpatterns = [
    path('', views.index, name='index'),
    path('bot990090865:AAH0k7HlxPkL9fj1Cn2ZSZ_9kav0lwKpYGo', TelegramBotView.as_view()), 
]