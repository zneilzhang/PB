HA$PBExportHeader$n_internet_result.sru
forward
global type n_internet_result from internetresult
end type
end forward

global type n_internet_result from internetresult
end type
global n_internet_result n_internet_result

forward prototypes
public function integer internetdata (blob data)
end prototypes

public function integer internetdata (blob data);MessageBox("Response",  String(data))
Return 1
end function

on n_internet_result.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_internet_result.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

