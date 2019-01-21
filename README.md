# TelegramBotCFML
This component allows you to call Telegram Bot API to your Coldfusion (CFML) applications.

## Resources

* Telegram Bot API: https://core.telegram.org/bots/api

## Examples

```js
var bot = new cfc.telegramBot(token = application.token);
asked = bot.dataParse(data = httpData);
if (asked.type == "command" && asked.command == "start") {
  bot.sendMessage(chat_id=asked.chat_id, text="Hello world!");
}
```