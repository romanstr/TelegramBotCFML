<cfscript>
// parse request
br = chr(13) & chr(10);
asked = bot.dataParse(data = httpData);

// command process
if( asked.type == 'text' ){
  // simple text recieved
} else if( asked.type == "callback" ){
  // callback
} else if( asked.type == "inline" ){
  // inline
  results = [];
} else if( asked.type == "command" ){
  switch(asked.command){
    case "echo":
      // echo command
      bot.sendMessage(chat_id=asked.chat_id, text=asked.args);
      break;
    case "start":
      // hello world
      bot.sendMessage(chat_id=asked.chat_id, text="Hello world!");
      break;
    case "forwardmessage":
      // forward current message to current chat
      bot.forwardMessage(chat_id=asked.chat_id, from_chat_id=asked.chat_id, message_id=asked.message_id);
      break;
    case "sendphoto":
      // sendphoto by url
      bot.sendPhoto(chat_id=asked.chat_id, photo={"type"="file", "value"= expandPath("TgBotTestPhoto.png")});
      break;
    case "sendaudio":
      // sendaudio by url
      bot.sendAudio(chat_id=asked.chat_id, audio={"type"="file", "value"= expandPath("TgBotTestAudio.wav")});
      break;
    case "senddocument":
      bot.sendDocument(
        chat_id = asked.chat_id, 
        caption = "document caption",
        document = {"type"="file", "value"= expandPath("TgBotTestDocument.docx")});
      break;
    case "sendvideo":
      bot.sendVideo(
        chat_id = asked.chat_id, 
        caption = "video caption",
        video = {"type"="file", "value"= expandPath("TgBotTestVideo.mp4")});
      break;
    case "sendanimation":
      bot.sendAnimation(
        chat_id = asked.chat_id, 
        caption = "animation caption",
        animation = {"type"="file", "value"= expandPath("TgBotTestVideo.mp4")});
      break;
    case "sendvoice":
      bot.sendVoice(
        chat_id = asked.chat_id, 
        caption = "voice caption",
        voice = {"type"="file", "value"= expandPath("TgBotTestVoice.ogg")});
      break;
    case "sendvideonote":
      bot.sendVideoNote(
        chat_id = asked.chat_id, 
        video_note = {"type"="file", "value"= expandPath("TgBotTestVideo.mp4")});
      break;
    case "sendmediagroup":
      bot.sendMediaGroup(
        chat_id = asked.chat_id, 
        media = [
          { "type"="photo", "media" = "https://image.jimcdn.com/app/cms/image/transf/none/path/s7571e757e08d9424/image/i2b2d03dbf9fd38c6/version/1365272387/image.jpg" },
          { "type"="photo", "mediaAttach" = expandPath("TgBotTestPhoto.png"), "caption" = "photo media attach" },
          { "type"="video", "mediaAttach" = expandPath("TgBotTestVideo.mp4") }
        ]);
      break;
    case "sendlocation":
      //sendlocation 46.84028 29.64333
      message = bot.sendLocation(
        chat_id = asked.chat_id, 
        live_period = 1200,
        latitude = listFirst(asked.args, " "),
        longitude = listLast(asked.args, " "));
      bot.sendMessage(
        chat_id=asked.chat_id, 
        text="message_id=" & message.message_id
      );
      break;
    case "editmessagelivelocation":
      //editmessagelivelocation 152 46.84028 29.64333
      message = bot.editMessageLiveLocation(
        chat_id = asked.chat_id,
        message_id = listGetAt(asked.args, 1, " "),
        latitude = listGetAt(asked.args, 2, " "),
        longitude = listGetAt(asked.args, 3, " "));
      break;
    case "stopmessagelivelocation":
      //stopmessagelivelocation 152
      message = bot.stopMessageLiveLocation(
        chat_id = asked.chat_id,
        message_id = listGetAt(asked.args, 1, " "));
      break;
    case "sendvenue":
      message = bot.sendVenue(
        chat_id = asked.chat_id,
        latitude = 48.858222,
        longitude = 2.294500,
        title = "Eiffel Tower",
        address = "5 Avenue Anatole France, 75007 Paris, France");
      break;
    case "sendcontact":
      message = bot.sendContact(
        chat_id = asked.chat_id,
        phone_number = "+7905123765",
        first_name = "Lenin");
      break;
    case "sendchataction":
      message = bot.sendChatAction(
        chat_id = asked.chat_id,
        action = "upload_photo");
      break;
    case "getuserprofilephotos":
      message = bot.getUserProfilePhotos(user_id = asked.user.id);
      bot.sendPhoto(chat_id=asked.chat_id, photo={"type"="id", "value"= message.photos[1][1].file_id});
      break;
  }
}

//https://www.google.com/maps?ll=48.858222,2.2945&q=48.858222,2.2945&hl=en&t=m&z=15
// bot.sendMessage(
//   chat_id=asked.chat_id, text=serializeJSON(message)
// );

</cfscript>