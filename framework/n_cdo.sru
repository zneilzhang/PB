HA$PBExportHeader$n_cdo.sru
forward
global type n_cdo from oleobject
end type
end forward

global type n_cdo from oleobject
end type
global n_cdo n_cdo

type variables

// Error

unsignedinteger	iiErrorNumber
string				isErrorText
string				isErrorWindowMenu
string				isErrorObject
string				isErrorScript
unsignedinteger	iiErrorLine
exceptionaction	ieaErrorAction
any					iaErrorReturnValue

// External exception

unsignedlong		ilExternalResultCode
unsignedlong		ilExternalExceptionCode
string				isExternalSource
string				isExternalDescription
string				isExternalHelpFile
unsignedlong		ilExternalHelpContext
exceptionaction	ieaExternalAction
any					iaExternalReturnValue

end variables

forward prototypes
public function unsignedlong uf_getexternalcode ()
public function unsignedlong uf_geterrorcode ()
public function string uf_tostring (any pavalue)
public function string uf_geterrortext ()
public function string uf_getexternaltext ()
end prototypes

public function unsignedlong uf_getexternalcode ();
return ilExternalResultCode

end function

public function unsignedlong uf_geterrorcode ();
return iiErrorNumber

end function

public function string uf_tostring (any pavalue);
if isNull(paValue) then return 'null!'

return string(paValue)

end function

public function string uf_geterrortext ();
string	lsText

lsText	= 'Number      = ' + uf_toString(iiErrorNumber) + '~r~n' &
			+ 'Text        = ' + uf_toString(isErrorText) + '~r~n' &
			+ 'WindowMenu  = ' + uf_toString(isErrorWindowMenu) + '~r~n' &
			+ 'Object      = ' + uf_toString(isErrorObject) + '~r~n' &
			+ 'Script      = ' + uf_toString(isErrorScript) + '~r~n' &
			+ 'Line        = ' + uf_toString(iiErrorLine) + '~r~n' &
			+ 'Action      = ' + uf_toString(ieaErrorAction) + '~r~n' &
			+ 'ReturnValue = ' + uf_toString(iaErrorReturnValue)

return lsText

end function

public function string uf_getexternaltext ();
string	lsText

lsText	= 'Result Code    = ' + uf_toString(ilExternalResultCode) + '~r~n' &
			+ 'Exception Code = ' + uf_toString(ilExternalExceptionCode) + '~r~n' &
			+ 'Source         = ' + uf_toString(isExternalSource) + '~r~n' &
			+ 'Description    = ' + uf_toString(isExternalDescription) + '~r~n' &
			+ 'Help File      = ' + uf_toString(isExternalHelpFile) + '~r~n' &
			+ 'Help Context   = ' + uf_toString(ilExternalHelpContext) + '~r~n' &
			+ 'Action         = ' + uf_toString(ieaExternalAction) + '~r~n' &
			+ 'ReturnValue    = ' + uf_toString(iaExternalReturnValue)

return lsText

end function

on n_cdo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cdo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event error;
iiErrorNumber			= errorNumber
isErrorText				= errorText
isErrorWindowMenu		= errorWindowMenu
isErrorObject			= errorObject
isErrorScript			= errorScript
iiErrorLine				= errorLine
ieaErrorAction			= action
iaErrorReturnValue	= returnValue

end event

event externalexception;
ilExternalResultCode		= resultCode
ilExternalExceptionCode	= exceptionCode
isExternalSource			= source
isExternalDescription	= description
isExternalHelpFile		= helpFile
ilExternalHelpContext	= helpContext
ieaExternalAction			= action
iaExternalReturnValue	= returnValue

action	= ExceptionIgnore!
end event

