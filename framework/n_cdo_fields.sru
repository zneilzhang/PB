HA$PBExportHeader$n_cdo_fields.sru
forward
global type n_cdo_fields from n_cdo
end type
end forward

global type n_cdo_fields from n_cdo
end type
global n_cdo_fields n_cdo_fields

type variables

constant string	cdoAttachmentFilename		= "urn:schemas:httpmail:attachmentfilename" 
constant string	cdoBcc							= "urn:schemas:httpmail:bcc" 
constant string	cdoCc								= "urn:schemas:httpmail:cc" 
constant string	cdoContentDispositionType	= "urn:schemas:httpmail:content-disposition-type" 
constant string	cdoContentMediaType			= "urn:schemas:httpmail:content-media-type" 
constant string	cdoDate							= "urn:schemas:httpmail:date" 
constant string	cdoDateReceived				= "urn:schemas:httpmail:datereceived" 
constant string	cdoFrom							= "urn:schemas:httpmail:from" 
constant string	cdoHasAttachment				= "urn:schemas:httpmail:hasattachment" 
constant string	cdoHTMLDescription			= "urn:schemas:httpmail:htmldescription" 
constant string	cdoImportance					= "urn:schemas:httpmail:importance" 
constant string	cdoNormalizedSubject			= "urn:schemas:httpmail:normalizedsubject" 
constant string	cdoPriority						= "urn:schemas:httpmail:priority" 
constant string	cdoReplyTo						= "urn:schemas:httpmail:reply-to" 
constant string	cdoSender						= "urn:schemas:httpmail:sender" 
constant string	cdoSubject						= "urn:schemas:httpmail:subject" 
constant string	cdoTextDescription			= "urn:schemas:httpmail:textdescription" 
constant string	cdoThreadTopic					= "urn:schemas:httpmail:thread-topic" 
constant string	cdoTo								= "urn:schemas:httpmail:to" 

long	ilCdoAttachmentFilename			= -1
long	ilCdoBcc								= -1
long	ilCdoCc								= -1
long	ilCdoContentDispositionType	= -1
long	ilCdoContentMediaType			= -1
long	ilCdoDate							= -1
long	ilCdoDateReceived					= -1
long	ilCdoFrom							= -1
long	ilCdoHasAttachment				= -1
long	ilCdoHTMLDescription				= -1
long	ilCdoImportance					= -1
long	ilCdoNormalizedSubject			= -1
long	ilCdoPriority						= -1
long	ilCdoReplyTo						= -1
long	ilCdoSender							= -1
long	ilCdoSubject						= -1
long	ilCdoTextDescription				= -1
long	ilCdoThreadTopic					= -1
long	ilCdoTo								= -1

end variables

forward prototypes
public function integer uf_setfrom (string psvalue)
public function integer uf_setsubject (string psvalue)
public function integer uf_settextdescription (string psvalue)
public function integer uf_setto (string psvalue)
public function long uf_getitemindex (string psitem)
public function long uf_additem (string psitem)
public function integer uf_setcc (string psvalue)
public function integer uf_setbcc (string psvalue)
end prototypes

public function integer uf_setfrom (string psvalue);
if ilCdoFrom < 0 then ilCdoFrom = uf_addItem(cdoFrom)

this.item[ilCdoFrom].value	= psValue

return 1

end function

public function integer uf_setsubject (string psvalue);
if ilCdoSubject < 0 then ilCdoSubject = uf_addItem(cdoSubject)

this.item[ilCdoSubject].value	= psValue

return 1

end function

public function integer uf_settextdescription (string psvalue);
if ilCdoTextDescription < 0 then ilCdoTextDescription = uf_addItem(cdoTextDescription)

this.item[ilCdoTextDescription].value	= psValue

return 1

end function

public function integer uf_setto (string psvalue);
if ilCdoTo < 0 then ilCdoTo = uf_addItem(cdoTo)

this.item[ilCdoTo].value	= psValue

return 1

end function

public function long uf_getitemindex (string psitem);
long	llItemIndex
long	llItemCount

llItemCount	= this.count() - 1

for llItemIndex = 0 to llItemCount
	if psItem = this.Item[llItemIndex].Name then return llItemIndex
next

return -1

end function

public function long uf_additem (string psitem);
long	llItemIndex
long	llItemCount

llItemIndex	= uf_getItemIndex(psItem)

if llItemIndex >= 0 then return llItemIndex

llItemCount	= this.count()

this.append(psItem, 8)

return llItemCount

end function

public function integer uf_setcc (string psvalue);if ilCdoCc < 0 then ilCdoCc = uf_addItem(cdoCc)

this.item[ilCdoCc].value	= psValue

return 1

end function

public function integer uf_setbcc (string psvalue);if ilCdoBcc < 0 then ilCdoBcc = uf_addItem(cdoBcc)

this.item[ilCdoBcc].value	= psValue

return 1

end function

on n_cdo_fields.create
call super::create
end on

on n_cdo_fields.destroy
call super::destroy
end on

