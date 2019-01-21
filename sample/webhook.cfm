<cfscript>
// parse request
br = chr(13) & chr(10);
asked = bot.dataParse(data = httpData);

// command process
if (asked.type == 'text') {
  // simple text recieved
  last = duplicate(getLastCommand(asked.chat_id));
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
}
</cfscript>