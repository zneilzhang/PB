HA$PBExportHeader$uo_httpresponse.sru
forward
global type uo_httpresponse from internetresult
end type
end forward

global type uo_httpresponse from internetresult
end type
global uo_httpresponse uo_httpresponse

type variables
private blob ibPayload
end variables

forward prototypes
public function integer internetdata (blob data)
public function blob getimage ()
public function string gethtml ()
end prototypes

public function integer internetdata (blob data);ibPayload = data
return 1
end function

public function blob getimage ();return ibPayload
end function

public function string gethtml ();return String(ibPayload, EncodingANSI!)
end function

on uo_httpresponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_httpresponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

