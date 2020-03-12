from django.shortcuts import render, redirect
from django.views.generic import View
from django.http import JsonResponse
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from . import config

import telebot

def index(request):
    pass
    return render(request, "chat_bot/index.html", {'test': 'Hello, World!'})

TOKEN = config.token
bot = telebot.TeleBot(TOKEN, threaded=False)

# так как вебхук уже подключен будем ждать новую информацию в TelegramBotView
class TelegramBotView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(TelegramBotView, self).dispatch(request, *args, **kwargs)

    def post(self, request):
        bot.process_new_updates([telebot.types.Update.de_json(request.body.decode('utf-8'))]) # тут мы уже получили новую инфу, эти изменения обновляем в боте
        return JsonResponse({'code': 'accepted'})

# КОД БОТА


@bot.message_handler(commands=['start']) 
def handle_start(message):
    user_id = message.from_user.id
    bot.send_message(user_id, 'Это старт?')

@bot.message_handler(content_types=['text']) # обычные сообщения
def handle_text(message):
    user_id = message.from_user.id
    text = message.text
    bot.send_message(user_id, 'Текст: ' + text)

@bot.message_handler(content_types=['contact']) # если отправили контакт
def get_contact(message):
    phone = message.contact.phone_number
    user_id = message.from_user.id
    bot.send_message(user_id, 'Твой номер?\n' + str(phone))

@bot.message_handler(content_types=['photo']) # если отправили фото
def handle(message):
    file_info = bot.get_file(message.photo[len(message.photo)-1].file_id)
    user_id = message.from_user.id


   

    bot.reply_to(message, 'yo.')

