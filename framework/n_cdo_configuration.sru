HA$PBExportHeader$n_cdo_configuration.sru
forward
global type n_cdo_configuration from n_cdo
end type
end forward

global type n_cdo_configuration from n_cdo
end type
global n_cdo_configuration n_cdo_configuration

type variables
constant long	cdoSendUsingPickup = 1
constant long	cdoSendUsingPort = 2 

constant string cdoAutoPromoteBodyParts = "http://schemas.microsoft.com/cdo/configuration/autopromotebodyparts" 
constant string cdoFlushBuffersOnWrite = "http://schemas.microsoft.com/cdo/configuration/flushbuffersonwrite" 
constant string cdoHTTPCookies = "http://schemas.microsoft.com/cdo/configuration/httpcookies" 
constant string cdoLanguageCode = "http://schemas.microsoft.com/cdo/configuration/languagecode" 
constant string cdoNNTPAccountName = "http://schemas.microsoft.com/cdo/configuration/nntpaccountname" 
constant string cdoNNTPAuthenticate = "http://schemas.microsoft.com/cdo/configuration/nntpauthenticate" 
constant string cdoNNTPConnectionTimeout = "http://schemas.microsoft.com/cdo/configuration/nntpconnectiontimeout" 
constant string cdoNNTPServer = "http://schemas.microsoft.com/cdo/configuration/nntpserver" 
constant string cdoNNTPServerPickupDirectory = "http://schemas.microsoft.com/cdo/configuration/nntpserverpickupdirectory" 
constant string cdoNNTPServerPort = "http://schemas.microsoft.com/cdo/configuration/nntpserverport" 
constant string cdoNNTPUseSSL = "http://schemas.microsoft.com/cdo/configuration/nntpusessl" 
constant string cdoPostEmailAddress = "http://schemas.microsoft.com/cdo/configuration/postemailaddress" 
constant string cdoPostPassword = "http://schemas.microsoft.com/cdo/configuration/postpassword" 
constant string cdoPostUserName = "http://schemas.microsoft.com/cdo/configuration/postusername" 
constant string cdoPostUserReplyEmailAddress = "http://schemas.microsoft.com/cdo/configuration/postuserreplyemailaddress" 
constant string cdoPostUsingMethod = "http://schemas.microsoft.com/cdo/configuration/postusing" 
constant string cdoSaveSentItems = "http://schemas.microsoft.com/cdo/configuration/savesentitems" 
constant string cdoSendEmailAddress = "http://schemas.microsoft.com/cdo/configuration/sendemailaddress" 
constant string cdoSendPassword = "http://schemas.microsoft.com/cdo/configuration/sendpassword" 
constant string cdoSendUserName = "http://schemas.microsoft.com/cdo/configuration/sendusername" 
constant string cdoSendUserReplyEmailAddress = "http://schemas.microsoft.com/cdo/configuration/senduserreplyemailaddress" 
constant string cdoSendUsingMethod = "http://schemas.microsoft.com/cdo/configuration/sendusing" 
constant string cdoSMTPAccountName = "http://schemas.microsoft.com/cdo/configuration/smtpaccountname" 
constant string cdoSMTPAuthenticate = "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate" 
constant string cdoSMTPConnectionTimeout = "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" 
constant string cdoSMTPServer = "http://schemas.microsoft.com/cdo/configuration/smtpserver" 
constant string cdoSMTPServerPickupDirectory = "http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory" 
constant string cdoSMTPServerPort = "http://schemas.microsoft.com/cdo/configuration/smtpserverport" 
constant string cdoSMTPUseSSL = "http://schemas.microsoft.com/cdo/configuration/smtpusessl" 
constant string cdoURLGetLatestVersion = "http://schemas.microsoft.com/cdo/configuration/urlgetlatestversion" 
constant string cdoURLProxyBypass = "http://schemas.microsoft.com/cdo/configuration/urlproxybypass" 
constant string cdoURLProxyServer = "http://schemas.microsoft.com/cdo/configuration/urlproxyserver" 
constant string cdoUseMessageResponseText = "http://schemas.microsoft.com/cdo/configuration/usemessageresponsetext" 

long ilCdoAutoPromoteBodyParts = -1
long ilCdoFlushBuffersOnWrite = -1
long ilCdoHTTPCookies = -1
long ilCdoLanguageCode = -1
long ilCdoNNTPAccountName = -1
long ilCdoNNTPAuthenticate = -1
long ilCdoNNTPConnectionTimeout = -1
long ilCdoNNTPServer = -1
long ilCdoNNTPServerPickupDirectory = -1
long ilCdoNNTPServerPort = -1
long ilCdoNNTPUseSSL = -1
long ilCdoPostEmailAddress = -1
long ilCdoPostPassword = -1
long ilCdoPostUserName = -1
long ilCdoPostUserReplyEmailAddress = -1
long ilCdoPostUsingMethod = -1
long ilCdoSaveSentItems = -1
long ilCdoSendEmailAddress = -1
long ilCdoSendPassword = -1
long ilCdoSendUserName = -1
long ilCdoSendUserReplyEmailAddress = -1
long ilCdoSendUsingMethod = -1
long ilCdoSMTPAccountName = -1
long ilCdoSMTPAuthenticate = -1
long ilCdoSMTPConnectionTimeout = -1
long ilCdoSMTPServer = -1
long ilCdoSMTPServerPickupDirectory = -1
long ilCdoSMTPServerPort = -1
long ilCdoSMTPUseSSL = -1
long ilCdoURLGetLatestVersion = -1
long ilCdoURLProxyBypass = -1
long ilCdoURLProxyServer = -1
long ilCdoUseMessageResponseText = -1

end variables

forward prototypes
public function long uf_getitemindex (string psitem)
public function integer uf_setlanguagecode (string psvalue)
public function integer uf_setnntpaccountname (string psvalue)
public function integer uf_setnntpconnectiontimeout (unsignedlong plvalue)
public function integer uf_setnntpserver (string psvalue)
public function integer uf_setnntpserverport (unsignedlong plvalue)
public function integer uf_setpostemailaddress (string psvalue)
public function integer uf_setpostpassword (string psvalue)
public function integer uf_setpostusername (string psvalue)
public function integer uf_setpostusing (unsignedlong plvalue)
public function integer uf_setsendemailaddress (string psvalue)
public function integer uf_setsendpassword (string psvalue)
public function integer uf_setsendusername (string psvalue)
public function integer uf_setsenduserreplyemailaddress (string psvalue)
public function integer uf_setsendusing (unsignedlong plvalue)
public function integer uf_setsmtpaccountname (string psvalue)
public function integer uf_setsmtpconnectiontimeout (unsignedlong plvalue)
public function integer uf_setsmtpserver (string psvalue)
public function integer uf_setsmtpserverport (unsignedlong plvalue)
public function integer uf_setusermessageresponsetext (boolean pbvalue)
public function integer uf_update ()
public function long uf_additem (string psitem)
end prototypes

public function long uf_getitemindex (string psitem);
long	llItemIndex
long	llItemCount

llItemCount	= this.Fields.count() - 1

for llItemIndex = 0 to llItemCount
	if psItem = this.Fields.Item[llItemIndex].Name then return llItemIndex
next

return -1

end function

public function integer uf_setlanguagecode (string psvalue);
if ilCdoLanguageCode < 0 then ilCdoLanguageCode = uf_addItem(cdoLanguageCode)

this.Fields.item[ilCdoLanguageCode].value	= psValue

return 1

end function

public function integer uf_setnntpaccountname (string psvalue);
if ilCdoNNTPAccountName < 0 then ilCdoNNTPAccountName = uf_addItem(cdoNNTPAccountName)

this.Fields.item[ilCdoNNTPAccountName].value	= psValue

return 1

end function

public function integer uf_setnntpconnectiontimeout (unsignedlong plvalue);
if ilCdoNNTPConnectionTimeout < 0 then ilCdoNNTPConnectionTimeout = uf_addItem(cdoNNTPConnectionTimeout)

this.Fields.item[ilCdoNNTPConnectionTimeout].value	= plValue

return 1

end function

public function integer uf_setnntpserver (string psvalue);
if ilCdoNNTPServer < 0 then ilCdoNNTPServer = uf_addItem(cdoNNTPServer)

this.Fields.item[ilCdoNNTPServer].value	= psValue

return 1

end function

public function integer uf_setnntpserverport (unsignedlong plvalue);
if ilCdoNNTPServerPort < 0 then ilCdoNNTPServerPort = uf_addItem(cdoNNTPServerPort)

this.Fields.item[ilCdoNNTPServerPort].value	= plValue

return 1

end function

public function integer uf_setpostemailaddress (string psvalue);
if ilCdoPostEmailAddress < 0 then ilCdoPostEmailAddress = uf_addItem(cdoPostEmailAddress)

this.Fields.item[ilCdoPostEmailAddress].value	= psValue

return 1

end function

public function integer uf_setpostpassword (string psvalue);
if ilCdoPostPassword < 0 then ilCdoPostPassword = uf_addItem(cdoPostPassword)

this.Fields.item[ilCdoPostPassword].value	= psValue

return 1

end function

public function integer uf_setpostusername (string psvalue);
if ilCdoPostUserName < 0 then ilCdoPostUserName = uf_addItem(cdoPostUserName)

this.Fields.item[ilCdoPostUserName].value	= psValue

return 1

end function

public function integer uf_setpostusing (unsignedlong plvalue);
if ilCdoPostUsingMethod < 0 then ilCdoPostUsingMethod = uf_addItem(cdoPostUsingMethod)

this.Fields.item[ilCdoPostUsingMethod].value	= plValue

return 1

end function

public function integer uf_setsendemailaddress (string psvalue);
if ilCdoSendEmailAddress < 0 then ilCdoSendEmailAddress = uf_addItem(cdoSendEmailAddress)

this.Fields.item[ilCdoSendEmailAddress].value	= psValue

return 1

end function

public function integer uf_setsendpassword (string psvalue);
if ilCdoSendPassword < 0 then ilCdoSendPassword = uf_addItem(cdoSendPassword)

this.Fields.item[ilCdoSendPassword].value	= psValue

return 1

end function

public function integer uf_setsendusername (string psvalue);
if ilCdoSendUserName < 0 then ilCdoSendUserName = uf_addItem(cdoSendUserName)

this.Fields.item[ilCdoSendUserName].value	= psValue

return 1

end function

public function integer uf_setsenduserreplyemailaddress (string psvalue);
if ilCdoSendUserReplyEmailAddress < 0 then ilCdoSendUserReplyEmailAddress = uf_addItem(cdoSendUserReplyEmailAddress)

this.Fields.item[ilCdoSendUserReplyEmailAddress].value	= psValue

return 1

end function

public function integer uf_setsendusing (unsignedlong plvalue);
if ilCdoSendUsingMethod < 0 then ilCdoSendUsingMethod = uf_addItem(cdoSendUsingMethod)

this.Fields.item[ilCdoSendUsingMethod].value	= plValue

return 1

end function

public function integer uf_setsmtpaccountname (string psvalue);
if ilCdoSMTPAccountName < 0 then ilCdoSMTPAccountName = uf_addItem(cdoSMTPAccountName)

this.Fields.item[ilCdoSMTPAccountName].value	= psValue

return 1

end function

public function integer uf_setsmtpconnectiontimeout (unsignedlong plvalue);
if ilCdoSMTPConnectionTimeout < 0 then ilCdoSMTPConnectionTimeout = uf_addItem(cdoSMTPConnectionTimeout)

this.Fields.item[ilCdoSMTPConnectionTimeout].value	= plValue

return 1

end function

public function integer uf_setsmtpserver (string psvalue);
if ilCdoSMTPServer < 0 then ilCdoSMTPServer = uf_addItem(cdoSMTPServer)

this.Fields.item[ilCdoSMTPServer].value	= psValue

return 1

end function

public function integer uf_setsmtpserverport (unsignedlong plvalue);
if ilCdoSMTPServerPort < 0 then ilCdoSMTPServerPort = uf_addItem(cdoSMTPServerPort)

this.Fields.item[ilCdoSMTPServerPort].value	= plValue

return 1

end function

public function integer uf_setusermessageresponsetext (boolean pbvalue);
if ilCdoUseMessageResponseText < 0 then ilCdoUseMessageResponseText = uf_addItem(cdoUseMessageResponseText)

this.Fields.item[ilCdoUseMessageResponseText].value	= pbValue

return 1

end function

public function integer uf_update ();
integer	liRetc = 1

n_cdo_fields	looFields

looFields	= create n_cdo_fields

looFields.setAutomationPointer(this.Fields)

looFields.Update()

if looFields.uf_getErrorCode() <> 0  then liRetc = -1
if looFields.uf_getExternalCode() <> 0 then liRetc = -1

destroy looFields

return 1

end function

public function long uf_additem (string psitem);
long	llItemIndex
long	llItemCount

llItemIndex	= uf_getItemIndex(psItem)

if llItemIndex >= 0 then return llItemIndex

llItemCount	= this.Fields.count()

this.Fields.append(psItem, 12)

return llItemCount

end function

on n_cdo_configuration.create
call super::create
end on

on n_cdo_configuration.destroy
call super::destroy
end on

