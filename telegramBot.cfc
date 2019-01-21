component accessors="true" {
  /**
  * @getter false
  * @setter true
  * @type string
  * @validate string
  * @hint Telegram Bot API Token
  **/
  property name="token" default="";

  /**
  * @setter true
  * @type string
  * @validate string
  * @hint Telegram Bot API Base URI
  **/
  property name="apiBaseUri" default="https://api.telegram.org/bot";

  /**
  * @getter true
  * @setter true
  * @type string
  * @validate string
  * @hint Telegram Bot API URI
  **/
  property name="apiUri" default="https://api.telegram.org/bot";


  public function init(required token){
    this.setToken(arguments.token);
    this.setApiUri( getApiBaseUri() & arguments.token & "/");
    return this;
  }

  public function dataParse(required data){
    if(NOT structKeyExists(data, "content")){
      throw(type="Application", message="Request incorrect (content is required)");
    }   
    var content = ToString(StructFind(data, "content"));
    if(NOT isJSON(content)){
      throw(type="Application", message="Request content incorrect (not JSON)");
    }
    var contentStruct = DeserializeJSON(content);



    var ret = {
      "type": "",
      "text": "",
      "document": "",
      "chat_id": "",
      "message_id": "",
      "callback_query_id": "",
      "user": {}
    };
    if(isDefined("contentStruct.message.from.id")){
      if(isDefined("contentStruct.message.text")){
        ret.type = "text";
        ret.text = contentStruct.message.text;
      } else if(isDefined("contentStruct.message.document")){
        ret.type = "document";
        ret.document = contentStruct.message.document;
      }
      ret.chat_id = contentStruct.message.from.id;
      ret.message_id = contentStruct.message.message_id;
      ret.user = contentStruct.message.from;
    } else if(isDefined("contentStruct.callback_query.data")){
      ret.type = "callback";
      ret.chat_id = contentStruct.callback_query.message.chat.id;
      ret.text = contentStruct.callback_query.data;
      ret.message_id = contentStruct.callback_query.message.message_id;
      ret.callback_query_id = contentStruct.callback_query.id;
      ret.user = contentStruct.callback_query.from;
    } else if(isDefined("contentStruct.inline_query.id")){
      ret.type = "inline";
      ret.chat_id = contentStruct.inline_query.from.id;
      ret.text = contentStruct.inline_query.query;
      ret["inline_query_id"] = contentStruct.inline_query.id;
      ret.user = contentStruct.inline_query.from;
    } else{
      throw(type="Application", message="Request incorrect. From field undefined");
    }

    if(ret.type == "text"){
      var command = "";
      var args = "";
      if(left(ret.text, 1) EQ "/" AND ret.text NEQ "/"){
        var firstSpace = find(" ", ret.text);
        if(firstSpace EQ 0){
          command = right(ret.text, len(ret.text)-1);
        } else {
          command = mid(ret.text, 2, firstSpace - 1);
        }
        command = trim(command);
        if(firstSpace GT 0){
          args = mid(ret.text, firstSpace+1, len(ret.text)-firstSpace);
        }
        ret.type = "command";
        ret["command"] = command;
        ret["args"] = args;
      }
    }

    contentStruct["!parsed"] = ret;

    return ret;
  }

  public function getMe(){
    return call(method = "getMe");
  }

  // + getMe
  // + sendMessage
  // + Formatting options
  // + forwardMessage
  // + sendPhoto
  // + sendAudio
  // + sendDocument
  // + sendVideo
  // sendAnimation
  // sendVoice
  // sendVideoNote
  // sendMediaGroup
  // sendLocation
  // editMessageLiveLocation
  // stopMessageLiveLocation
  // sendVenue
  // sendContact
  // sendChatAction
  // getUserProfilePhotos
  // getFile
  // kickChatMember
  // unbanChatMember
  // restrictChatMember
  // promoteChatMember
  // exportChatInviteLink
  // setChatPhoto
  // deleteChatPhoto
  // setChatTitle
  // setChatDescription
  // pinChatMessage
  // unpinChatMessage
  // leaveChat
  // getChat
  // getChatAdministrators
  // getChatMembersCount
  // getChatMember
  // setChatStickerSet
  // deleteChatStickerSet
  // answerCallbackQuery

  /**
  * @hint Use this method to receive incoming updates using long polling (wiki). An Array of Update objects is returned. https://core.telegram.org/bots/api/#getupdates
  **/
  public function getUpdates(integer offset, integer limit, integer timeout, array allowed_updates){
    return call(method = "getUpdates", params = arguments);
  }

  /**
  * @hint Use this method to specify a url and receive incoming updates via an outgoing webhook.
  **/
  public function setWebhook(required string url, struct certificate, integer max_connections, array allowed_updates){
    return call(method = "setWebhook", params = arguments);
  }

  /**
  * @hint Use this method to remove webhook integration if you decide to switch back to getUpdates. Returns True on success. Requires no parameters.
  **/
  public function deleteWebhook(){
    return call(method = "deleteWebhook");
  }

  /**
  * @hint Use this method to get current webhook status. Requires no parameters. On success, returns a WebhookInfo object. If the bot is using getUpdates, will return an object with the url field empty.
  **/
  public function getWebhookInfo(){
    return call(method = "getWebhookInfo");
  }

  /**
  * @hint Use this method to send text messages. On success, the sent Message is returned.
  **/
  public function sendMessage(integer chat_id, string text, string parse_mode, boolean disable_web_page_preview, boolean disable_notification, integer reply_to_message_id, reply_markup){
    return call(method = "sendMessage", params = arguments);
  }

  /**
  * @hint Use this method to forward messages of any kind. On success, the sent Message is returned.
  **/
  public function forwardMessage(required string chat_id, required string from_chat_id, boolean disable_notification, required integer message_id){
    return call(method = "forwardMessage", params = arguments);
  }
  
  /**
  * @hint Use this method to send photos. On success, the sent Message is returned.
  **/
  public function sendPhoto(required integer chat_id, required photo, string caption, string parse_mode, boolean disable_notification, integer reply_to_message_id, reply_markup){
    normalizeArguments(args = arguments);
    return call(method = "sendPhoto", params = arguments);
  }

  /**
  * @hint Use this method to send audio files
  **/
  public function sendAudio(required integer chat_id, required audio, string caption, string parse_mode, integer duration, string performer, string title, thumb, boolean disable_notification, integer reply_to_message_id, reply_markup){
    normalizeArguments(args = arguments);
    return call(method = "sendAudio", params = arguments);
  }

  /**
  * @hint Use this method to send general files
  **/
  public function sendDocument(required integer chat_id, required document, thumb, string caption, string parse_mode, boolean disable_notification, integer reply_to_message_id, reply_markup){
    normalizeArguments(args = arguments);
    return call(method = "sendDocument", params = arguments);
  }

  /**
  * @hint Use this method to send video files
  **/
  public function sendVideo(required integer chat_id, required video, integer duration, integer width, integer height, thumb, string caption, string parse_mode, boolean supports_streaming, boolean disable_notification, integer reply_to_message_id, reply_markup){
    normalizeArguments(args = arguments);
    return call(method = "sendVideo", params = arguments);
  }

  public function answerInlineQuery(required string inline_query_id, required results){
    return call(method = "answerInlineQuery", params = arguments);
  }

  /**
  * @hint Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert.
  **/
  public function answerCallbackQuery(required string callback_query_id, string text, boolean show_alert, string url, integer cache_time){
    normalizeArguments(args = arguments);
    return call(method = "answerCallbackQuery", params = arguments);
  }


  private function normalizeArguments(args){
    for(argKey in args){
      if(structKeyExists(args, argKey)){
        if( arrayFind(["photo", "audio", "document", "video"], lCase(argKey)) AND isStruct(args[argKey]) ){
          if(args[argKey].type == "id" || args[argKey].type == "url"){
            args[argKey] = args[argKey].value;
          } else if(args[argKey].type == "file") {
            args[argKey].file = args[argKey].value;
            args[argKey].httpparam = "file";
            structDelete(args[argKey], "value");
          }
        }
      } else {
        structDelete(args, argKey);
      }
    }
  }

  private function photoMerge(args){
    ArrayEach(["photo_id", "photo_url", "photo_path"], function(param){
      if(structKeyExists(args, param)){
        if(param == "photo_id" || param == "photo_url"){
          args["photo"] = args[param];
        } else{
          args["photo"] = {type="file", file=args[param]};
        }
        structDelete(args, param);
      }
    });
  }

  private function urlMake(required string method){
    return getApiUri() & arguments.method;
  }

  private struct function requestHttp(required string method, params = {}) {
    var url = urlMake(method = arguments.method);
    var httpService = new http();

    params = params.filter(function(key, value){
      return isDefined("value");
    });

    httpService.setMethod( params.isEmpty() ? "get" : "post" );
    httpService.setUrl(url);
    for(paramKey in params){
      if(isStruct(params[paramKey]) && structKeyExists(params[paramKey], "httpparam") && structKeyExists(params[paramKey], "file") ){
        httpService.addParam(type=params[paramKey].type, name=lCase(paramKey), file = params[paramKey].file );
      }
      else if(isStruct(params[paramKey]) || isArray(params[paramKey]) ){
        httpService.addParam(type="formfield", name=lCase(paramKey), value = serializeJSON(params[paramKey]) );
      } else{
        httpService.addParam(type="formfield", name=lCase(paramKey), value = params[paramKey] );
      }
    }
    var result = httpService.send().getPrefix();
    //writeDump(result);
    return result;
  }

  private any function call(required string method, struct params = {}){
    var result = requestHttp(argumentCollection = arguments);
    if(result.statusCode EQ "200 OK"){
      if(result.mimeType EQ "application/json"){
        return responce(content = result.fileContent);
      }
    }
    return {};
  }

  private any function responce(required content){
    var responce = deserializeJSON(arguments.content);
    return (responce.ok ? responce.result : {});
  }

  public string function stripHTML(str) {
    // remove the whole tag and its content
    var list = "style,script,noscript,br";
    for (var tag in list){
      str = reReplaceNoCase(str, "<s*(#tag#)[^>]*?>(.*?)","","all");
    }

    str = reReplaceNoCase(str, "<.*?>","","all");
    //get partial html in front
    str = reReplaceNoCase(str, "^.*?>","");
    //get partial html at end
    str = reReplaceNoCase(str, "<.*$","");

    return trim(str);
  }
}