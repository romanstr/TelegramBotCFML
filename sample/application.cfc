component {
	this.name = "TgBotSample" & CGI.SERVER_NAME;
	this.applicationTimeout = CreateTimeSpan(0, 10, 0, 0); //10 hours
	this.sessionManagement = true;
	this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0); //30 minutes
	this.customTagPaths = [];
	this.mappings = {
		"/cfc" = expandPath("../")
	};

	function onApplicationStart() {
		var fileToken = fileOpen(expandPath("token.txt"));
		application.token = trim(fileReadLine(fileToken));
		fileClose(fileToken);
		application.tBot = new cfc.telegramBot(token = application.token);
		return true;
	}

	function onSessionStart() {

	}

	// the target page is passed in for reference, 
	// but you are not required to include it
	function onRequestStart( string targetPage ) {
		if( isDefined("URL.appRestartPlease") ){
			ApplicationStop();
		}
	}

	function onRequest( string targetPage ) {
		bot = application.tBot;
		httpData = GetHttpRequestData();
		include arguments.targetPage;
	}

	function onRequestEnd() {}

	function onSessionEnd( struct SessionScope, struct ApplicationScope ) {}

	function onApplicationEnd( struct ApplicationScope ) {}
}