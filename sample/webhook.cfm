<cfscript>
// parse request
br = chr(13) & chr(10);
asked = bot.dataParse(data = httpData);

// command process
if (asked.type == 'text') {
  // simple text recieved
} else if (asked.type == "callback") {
  // callback
} else if (asked.type == "inline") {
  // inline
  results = [];
} else if (asked.type == "command" && asked.command == "echo") {
  // echo command
  bot.sendMessage(chat_id=asked.chat_id, text=asked.args);
} else if (asked.type == "command" && asked.command == "start") {
  // hello world
  bot.sendMessage(chat_id=asked.chat_id, text="Hello world!");
} else if (asked.type == "command" && asked.command == "forwardmessage") {
  // forward current message to current chat
  bot.forwardMessage(chat_id=asked.chat_id, from_chat_id=asked.chat_id, message_id=asked.message_id);
} else if (asked.type == "command" && asked.command == "sendphoto") {
  // sendphoto by url
  bot.sendPhoto(chat_id=asked.chat_id, photo={"type"="file", "value"= expandPath("TgBotTestPhoto.png")});
} else if (asked.type == "command" && asked.command == "sendaudio") {
  // sendaudio by url
  bot.sendAudio(chat_id=asked.chat_id, audio={"type"="file", "value"= expandPath("TgBotTestAudio.wav")});
}
</cfscript>