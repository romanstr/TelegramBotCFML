<cfscript>
writeDump(bot.setWebhook(url="https://" & cgi.server_name & replaceNoCase(cgi.script_name, "webhookSet.cfm", "webhook.cfm") ))
</cfscript>