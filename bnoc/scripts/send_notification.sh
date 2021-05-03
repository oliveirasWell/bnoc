#!/bin/bash

set -e

# Telegram variables
chatId=$CHATID
botKey=$BOTKEY

sendMsg(){
  curl -s -X POST -H 'Content-Type: application/json' -d "{\"chat_id\": \"$chatId\", \"text\": \"$1\", \"disable_notification\": false}"  "https://api.telegram.org/bot$botKey/sendMessage"
}

sendFile(){
  curl  -F "chat_id=$chatId" -F "document=@$1" "https://api.telegram.org/bot$botKey/sendDocument"
}

sendErr(){
  sendMsg "An error occurred while running the srun"
}