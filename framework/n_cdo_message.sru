HA$PBExportHeader$n_cdo_message.sru
forward
global type n_cdo_message from n_cdo
end type
end forward

global type n_cdo_message from n_cdo
end type
global n_cdo_message n_cdo_message

event constructor;//
end event

on n_cdo_message.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cdo_message.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

